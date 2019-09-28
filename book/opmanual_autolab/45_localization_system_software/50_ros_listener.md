
# The ROS listener {#localization-ros-listener status=ready}

Excerpt: The details of the first layer of the system, the ros wrapper

<div class='requirements' markdown="1">

Requires: 

Results: 
</div>

<minitoc/> 


This layer has the rode node. It can work either online or offline:

- Online : it has ros subscriber to `/pose_acquisition/poses` and `/pose_acquisition/odometry`, which respectively receive transforms from apriltag detection and odometry transforms
- Offline : it receives a rosbag containing the same type of information and plays it back to the same subscribers

The purpose of this node is to feed transforms to the resampler (that feeds them to the graph builder). The transforms all need to be formatted the same way and have consistent agent names between them (see example below). To do so, there is some work

## For apriltag transforms

Upon receiving a apriltag transform, we needs to filter the transform's following attributes:

- `header.frame_id` --> agent which detected the apriltag
- `header.tag_id` --> apriltag number

The `frame_id` will always be a duckiebot or a watchtower, for instance `autobot01` or `watchtower03`.
But the `tag_id` will always be a number. We therefore need a list of apriltag attribution. For instance, the default attribution of apriltag 402 is `autobot03`, but the one for apriltag 53 is a traffic sign. 

There are three possible case for a apriltag message:

- A watchtower sees an autobot, then `tag_id` is for instance 402
- A watchtower sees any other apriltag, then `tag_id` is not in the 4XX
- An Autobot sees any apriltag, they never see other autobots' apriltags

The main issue is then that autobot03 is referred as 402 when seen, but as itself when it send a transform. So, thanks to the list of attribution, in the first case, we change the tag_id to `autobot03`.

## For odometry transforms

Upon receiving a odometry transform, we get the transform's following attributes:

- `header.frame_id`
- `header.child_frame_id`

The two are the same, since an odometry transform is just a transform between the autobot at time t1 and the autobot at time t2.

## Frames of reference and associated transformations

Let's formalize some frame definitions:

The **autobot** has three important frames to consider:

- The `autobot_base` frame, located on the top red plate, center of the wheels, X forward, Y left and Z upward (in the driving direction). This is the frame that is considered for the graph.
- The `autobot_apriltag` frame, which is on top of the bot
- The `autobot_camera` frame, which is centered in the lens, Z forward, Y down, X right. And the camera is mounted on a 10 degrees stand.
All three frames are attached by static transforms (meaning they don't change relative poses to one another).

The **watchtower** just has one frame, called `watchtower_camera`. It is the one of the camera, described as the one of the `autobot_camera`.

The rest of the **apriltags** have also one frame, called `apriltag_base`.

Since we want to consider the autobot only in its `autobot_base` frame, this means two things:

- The transforms from the watchtowers to the autobots are actually from `watchtower_camera` to `autobot_apriltag`. They therefore need to be transferred to be `watchtower_camera` to `autobot_base`. The `autobot_apriltag` to `autobot_base` is a known transform that is applied to all such transforms. 
- Similarly, the messages coming from autobots cameras are `autobot_camera` to `apriltag_base`, so we transform them to `autobot_base` to `apriltag_base` by using the know static transform `autobot_base` to `autobot_camera`. Note that in the first case, it is a right multiplication, and in the second a left multiplication (in SE3).

Todo: Add pictures

## The importance of time stamps

Each odometry or apriltag transform message comes with a timestamp. Since we want to track the movement in time of each autobot, those are very important to keep and transmit with the transform.

For things that don't move, e.g. the watchtowers and the apriltags that are not on autobots, we don't need to keep the timestamp. This only happens when the transform is from a `watchtower_camera` to an `apriltag_base` (which is not on an autobot).

## To conclude

The ROS listener makes sure to transmit transforms with the right frame ids (parent and child), to the right frames of reference (`autobot_base` for the autobots), with the right time stamps.

At the end of the pipeline, it receives back optimized estimates of the trajectories of the autobots and of the positions of the watchtowers. It then publishes them and stores them.