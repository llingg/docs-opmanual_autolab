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

**Let's call $t_{query}$ the timestamp of the query.**

### For the Apriltag transforms

For each Watchtower, for each `AutobotXX` seen by Watchtower:

Let's call $t_{prev}$ and $t_{next}$ respectively the closest timestamps before and after $t_{query}$ such that the Watchtower has transforms to `AutobotXX` at $H_{prev}$ at $t_{prev}$ and transform $H_{next}$ at $t_{next}$. 

First, we compute from those two transforms the transform $H_{movement}$ that is the movement of the Autobot from $t_{prev}$ to $t_{next}$:

\[
    H_{movement} = H_{next} \cdot H_{prev}^{-1}
\]

Then we "crop" this H_movement to only take the part happening from $t_{prev}$ to $t_{query}$:

\[
    H_{movement-cropped} = interpolation(H_{movement}, t_{query})
\]


Then we left-multiply it by $H_{prev}$ to finally get the transform from the camera frame to the duckiebot at time $t_query$:

\[
    H_{query} = H_{prev} \cdot H_{movement-cropped}
\]

This will give the best approximation of the transform at $t_{query}$. Of course, this is done only if $t_{prev}$ and $t_{next}$ exist and are close enough to $t_{query}$. We use the Lie Algebra of SE3 to compute the interpolation.

This is then the output $H_{query}$ that is called resampled transform.

What this ensures is that if multiple Watchtowers see `AutobotXX` at the same time, their inputs will be synchronized and linked to the same node in the duckietown graph builder.

Todo: Add image to explain

### For the odometry transforms

For each Autobot, the sequence of odometry transforms are stored. As said before, for the odometry two time stamps are required as the transform is a transform of time, not of space. Hence, we store the previous queried time, called $t_{query-prev}$, and calculate the odometry transform between $t_{query-prev}$ and $t_{query}$.

This means that we need to get :

* $t_{prev}$ : the time stamp closest before $t_{query-prev}$
* $t_{next}$ : the time stamp closest after $t_{query}$
* [$t_{1}$, $t_{2}$, ..., $t_{n}$], the `n` timestamps for of odometry messages between $t_{query-prev}$ and $t_{query}$

Note: `n` depends on the difference between the query rate and the odometry rate. If the odometry rate is 30Hz and the query rate is 10Hz, then n will usually be 2. If both rate are comparable, `n` might be zero and the following algorithm just does the two first interpolations as one.

**Then**, we do two interpolations :

* The transform $H_{prev}$ which is between $t_{query-prev}$ and $t_{1}$ (we need the odometry at time $t_{prev}$ to compute it).
* The transform $H_{final}$ which is between $t_{n}$ and $t_{query}$

**Then**, we have the transforms $[H_{1-to-2}, H_{2-to-3}, ..., H_{(n-1)-to-n}]$ that are the `n-1` inner transforms. By direct multiplication, we have that the requested $H_{query}$ is:
\[
    H_{query} = H_{prev} \cdot H_{1-to-2} \cdot H_{2-to-3} \cdot ... \cdot H_{(n-1)-to-n} \cdot H_{final}
\]

This is then the output $H_{query}$ that is called resampled transform.

Todo: Add image to explain
