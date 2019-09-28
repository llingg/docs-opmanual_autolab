# The Resampler {#localization-resampler status=ready}

Excerpt: The details of the second layer of the system, the resampler

<div class='requirements' markdown="1">

Requires: 

Results: 
</div>

<minitoc/> 


## What is the resampler and why do we need it?

The input of the graph consist of multiple non synchronized streams of data from multiple agents. At one point in time, for one autobot, there can be up to about 5 watchtowers that see it, each with a ~20Hz stream. Adding to this the odometry stream of the autobot (about 30Hz) and the image stream of the autobot (about 30Hz as well), we can end up with a total of 160 different time stamps to give to the autobot per seconds. This makes no sense, as we cant possibly want a trajectory with higher frame rate as the lowest frame rate of the sensors.

The resampler's goal is to generate a synchronized and regular stream of transforms for the graph optimizer. What it does is:

- For each autobot, keeps the odometry transform history
- For each watchtower, keeps the transform history of each detected autobot
- The transforms from watchtowers to other apriltags are transmitted directly to the graph optimizer, as we don't keep their timestamps.

Then, at a regular interval (default is 15Hz), each sensor is queried for a transform.

Let's call `t_query` the timestamp of the query.

For each watchtower, for each `autobotXX` seen by watchtower:

let's call `t_prev` and `t_next` respectively the closest timestamps before and after `t_query` such that the watchtower has transforms to `autobotXX` at `H_prev` at `t_prev` and transform `H_next` at `t_next`. Then we compute the corresponding queried transform `H_query` as a SE3 interpolation of `H_prev` and `H_next`. This will give the best approximation of the transform at `t_query`. Of course, this is done only if `t_prev` and `t_next` exist and are close enough to `t_query`.

What this ensures is that if multiple watchtowers see `autobotXX` at the same time, their inputs will be synchronized and linked to the same node in the duckietown graph builder.

Todo: odometry
