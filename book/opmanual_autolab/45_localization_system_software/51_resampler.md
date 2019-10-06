# The Resampler {#localization-resampler status=ready}

Excerpt: The details of the second layer of the system, the resampler

<div class='requirements' markdown="1">

Requires: Knowing the role of the ROS listener (layer 1) of the localization system does. [](#localization-ros-listener)

Results: Knowing what the resampler does and why. 
</div>

<minitoc/> 

## The place of the layer in the bigger picture

As stated in [](#part:autolab-localization-software), the localization graph optimizer works in layers:

* 1) The **ROS listener**, that receives the transforms data from the apriltag extraction and odometry
* 2) The **Resampler**, that filter the data inside the graph
* 3) The **Duckietown Graph Builder**, that creates and manage the graph
* 4) The **g2o graph builder**, a custom wrapper around the g2o library.

This part of the docs focuses on **layer 2, the Resampler**.

Note: **Notation**: This layer receives **formatted transforms** and outputs **resampled transforms** to the [duckietown graph builder](#localization-duckietown-graph-builder).

## What is the resampler and why do we need it

### The problem

The input of the resampler consists of multiple non synchronized streams of data from multiple agents. At one point in time, for one Autobot, there can be up to about 5 Watchtowers that see it, each with a ~20Hz stream. Adding to this the odometry stream of the Autobot (about 30Hz) and the image stream of the Autobot (about 30Hz as well), we can end up with a total of 160 different time stamps to give to the Autobot per seconds. This makes no sense, as we cant possibly output a trajectory with higher frame rate as the lowest frame rate of the sensors.

### The solution

The resampler's goal is to generate a synchronized and regular stream of transforms for the graph optimizer, which we call the **resampled transforms**. The process will allow the layer 3 of the system, the duckietown graph builder, to build a graph with less nodes, at a controlled rate.

## Working principle

What the resampler does is:

* For each Autobot, it keeps the odometry transform history
* For each Watchtower, it keeps the transform history of each detected Autobot
* The transforms from Watchtowers to other apriltags are transmitted directly to the graph optimizer, as we don't keep their timestamps.

Then, at a regular interval (the default rate is 15Hz), each sensor is queried for a transform.

**Let's call $t_{\text{query}}$ the timestamp of the query.**

### For the Apriltag transforms

For each Watchtower, for each `AutobotXX` seen by Watchtower:

Let's call $t_{\text{prev}}$ and $t_{\text{next}}$ respectively the closest timestamps before and after $t_{\text{query}}$ such that the Watchtower has transforms to `AutobotXX` at $H_{\text{prev}}$ at $t_{\text{prev}}$ and transform $H_{\text{next}}$ at $t_{\text{next}}$.

<div figure-id="fig:watchtower-resampler-1">
<img src="images/resampler/watchtower-resampler-Page-1.svg" style="width: 50%"/>
<figcaption> We have two transforms from the Watchtower to the Autobot, only at times $t_{\text{prev}}$ and $t_{\text{next}}$ </figcaption>
</div>

First, we compute from those two transforms the transform $H_{\text{movement}}$ that is the movement of the Autobot from $t_{\text{prev}}$ to $t_{\text{next}}$:

\[
    H_{\text{movement}} = H_{\text{next}} \cdot H_{\text{prev}}^{-1}
\]

<div figure-id="fig:watchtower-resampler-2">
<img src="images/resampler/watchtower-resampler-Page-2.svg" style="width: 50%"/>
<figcaption> $H_{\text{movement}} = H_{\text{next}} \cdot H_{\text{prev}}^{-1}$ </figcaption>
</div>

<div figure-id="fig:watchtower-resampler-3">
<img src="images/resampler/watchtower-resampler-Page-3.svg" style="width: 55%"/>
<figcaption> Extrapolating the Autobot's position at $t_{\text{query}}$ </figcaption>
</div>

Then we "crop" this H_movement to only take the part happening from $t_{\text{prev}}$ to $t_{\text{query}}$:

\[
    H_{\text{movement-cropped}} = \text{interpolation}(H_{\text{movement}}, t_{\text{query}})
\]

<div figure-id="fig:watchtower-resampler-4">
<img src="images/resampler/watchtower-resampler-Page-4.svg" style="width: 50%"/>
<figcaption> Taking only the first part of the transform </figcaption>
</div>

Then we left-multiply it by $H_{\text{prev}}$ to finally get the transform from the camera frame to the duckiebot at time $t_query$:

\[
    H_{\text{query}} = H_{\text{prev}} \cdot H_{\text{movement-cropped}}
\]

<div figure-id="fig:watchtower-resampler-5">
<img src="images/resampler/watchtower-resampler-Page-5.svg" style="width: 50%"/>
<figcaption> Creating $H_{\text{query}}$ from the computed interpolation </figcaption>
</div>

This will give the best approximation of the transform at $t_{\text{query}}$. Of course, this is done only if $t_{\text{prev}}$ and $t_{\text{next}}$ exist and are close enough to $t_{\text{query}}$. We use the Lie Algebra of SE3 to compute the interpolation.

This is then the output $H_{\text{query}}$ that is called resampled transform.

What this ensures is that if multiple Watchtowers see `AutobotXX` at the same time, their inputs will be synchronized and linked to the same node in the duckietown graph builder.

<div figure-id="fig:watchtower-resampler-6">
<img src="images/resampler/watchtower-resampler-Page-6.svg" style="width: 50%"/>
<figcaption> Without the resampler, all transforms are not synchronized, this will create 4 separated nodes in the graph </figcaption>
</div>

<div figure-id="fig:watchtower-resampler-7">
<img src="images/resampler/watchtower-resampler-Page-7.svg" style="width: 50%"/>
<figcaption> With the resampler, we query the same time for each watchtower, thus synchronizing the data </figcaption>
</div>

### For the odometry transforms

For each Autobot, the sequence of odometry transforms are stored. As said before, for the odometry two time stamps are required as the transform is a transform of time, not of space. Hence, we store the previous queried time, called $t_{\text{query-prev}}$, and calculate the odometry transform between $t_{\text{query-prev}}$ and $t_{\text{query}}$.

This means that we need to get :

* $t_{\text{prev}}$ : the time stamp closest before $t_{\text{query-prev}}$
* $t_{\text{next}}$ : the time stamp closest after $t_{\text{query}}$
* [$t_{\text{1}}$, $t_{\text{2}}$, ..., $t_{\text{n}}$], the `n` timestamps for of odometry messages between $t_{\text{query-prev}}$ and $t_{\text{query}}$

Note: `n` depends on the difference between the query rate and the odometry rate. If the odometry rate is 30Hz and the query rate is 10Hz, then n will usually be 2. If both rate are comparable, `n` might be zero and the following algorithm just does the two first interpolations as one.

**Then**, we do two interpolations :

* The transform $H_{\text{prev}}$ which is between $t_{\text{query-prev}}$ and $t_{\text{1}}$ (we need the odometry at time $t_{\text{prev}}$ to compute it).
* The transform $H_{\text{final}}$ which is between $t_{\text{n}}$ and $t_{\text{query}}$

**Then**, we have the transforms $[H_{\text{1-to-2}}, H_{\text{2-to-3}}, ..., H_{\text{(n-1)-to-n}}]$ that are the `n-1` inner transforms. By direct multiplication, we have that the requested $H_{\text{query}}$ is:
\[
    H_{\text{query}} = H_{\text{prev}} \cdot H_{\text{1-to-2}} \cdot H_{\text{2-to-3}} \cdot ... \cdot H_{\text{(n-1)-to-n}} \cdot H_{\text{final}}
\]

This is then the output $H_{\text{query}}$ that is called resampled transform.

Todo: Add image to explain
