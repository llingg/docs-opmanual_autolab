# Localization System - Software explanation {#part:autolab-localization-software status=ready}

Excerpt: The whole localization software explained

<div class='requirements' markdown="1">

Requires: The code for localization (in [dt-env-developer](#dt-env-developer))

Results: Better knowledge of the working of the current localization pipeline

Next Steps: Contribute to make it better 
</div>

<minitoc/>

## Goals and specifications of the localization system

For all Autobots in the Autolab:

* 10 Hz rate pose trajectory (position and orientation)
* 1 cm accuracy
* 5 degree accuracy (less important maybe)

## Outline of the code structure

Note: In all the following, an agent will refer indifferently to a Watchtower or an Autobot.

The pipeline is roughly the following:

* Every agent has a camera flow of image that is either recorded to be used later or directly sent to a processor
* The processor (can be the agent itself or a central powerful computer) takes each image and extract, for each found Apriltag, the relative pose between the camera frame and the Apriltag frame, with the Apriltag ID and the time stamp of the image. This result is a stamped Apriltag transform.
* This set of transforms is sent to a graph builder, that uses all those to create a big graph in G2O, a graph optimization library.
* The graph builder does a lot of work (described below) to recreate and synchronize the time dependency of a moving Autobot (which, contrary to Watchtowers, cannot be represented as one vertex in the graph, but rather as successive vertices with unique time stamps).
* The graph is regularly optimized, and the trajectory of each Autobot is extracted.

The global frame is fixed thanks to the measured ground Apriltags, that are fed into the graph at initialization, and set as fixed points of the graph.

## Camera parameters

### Autobot camera parameters

The Autobots already use a camera feed that is medium quality on the normal pipeline. All we do here is use the same image stream.
Todo: add actual quality 

### Watchtower camera parameters

For the Watchtowers it is a different story. As it is not used (yet) for anything else, we decided for the below reason to use a better image resolution and a higher shutter speed:

* The cameras are high, so the relative size of the Apriltags is small, so higher resolution mean better detection of the Apriltags (especially on the edges of the image)
* The Autobots are (mostly) always moving, and this created blur with the default shutter speed. With a higher shutter speed, we really decreased the blur, and the resulting loss of light is barely noticeable.

Todo: add images to see the difference

Todo: add actual numbers (resolution and shutter speed)


## Apriltag detection

From here, there are many different ways of doing things. The Apriltag detection is very computationally expensive, and different strategies can be used:

* Offline acquisition : each agent just records the images, then they are gathered and processed later, offline, without any time requirement. This is the easy, but unsatisfactory way. This also means that the localization can only be used *a posteriori*, so it can not be used for real time decision making.
* Online acquisition : the images are processed during the experiment, and the graph and localization is done (with some delay) online. This is much harder to do as processing images is costly. Two strategies can be used here:
    * Each agent tries to do the processing directly onboard and just sends the transforms to a central ROS master that will do the graph
    * Each agent directly sends the images and the central ROS master does the processing for every agent (implies having a good computer)
    * A mix of the two is also possible (the Autobot send the images, the watchtowers process them for instance)


### Offline acquisition of images

As explained in [](#localization-demo), the offline localization just needs every agent to record in rosbags the image stream. Then, it is download and feed to a Apriltag extractor node, that outputs all the transforms to a new bag, that is then fed to the graph optimizer. 

### Online acquisition of images

To do online, there is a whole new thing to worry about: How to communicate between different ROS masters.

Remember, each agent has its own ROS master, and they cannot communicate with each other natively, even though they are on the same network.

The currently used solution is to:

* Create a new central ROS master
* On each agent, create a "bridge" node that communicates with the agent's ROS master and the central ROS master
* Through this bridge node, get all the images from the agents to the centra ROS master

Todo: Actually explain how we do that.

### Apriltag extraction

No matter how (or on which device) we get the image, we need to process it to get two things for each Apriltag in the image:

* its relative pose
* its unique Id

Todo: explain what a transform is
Todo: explain process and code, link repos etc...



## Graph building and optimization

The graph optimizer works in layers:

- 1) The **ROS listener**, that receives the transforms data from the apriltag extraction and odometry
- 2) The **Resampler**, that filter the data inside the graph
- 3) The **Duckietown Graph Builder**, that creates and manage the graph
- 4) The **g2o graph builder**, a custom wrapper around the g2o library.

The data flow from layer 1 all the way to layer 4. At layer 4, a graph is built and optimized and the result is then transfered back to layer 1, that stores and broadcasts it. Let's take a look at each layer individually.

### The Ros Listener

This layer has the rode node. It can work either online or offline:

- Online : it has ros subscriber to `/pose_acquisition/poses` and `/pose_acquisition/odometry`, which respectively receive transforms from apriltag detection and odometry transforms
- Offline : it receives a rosbag containing the same type of information and plays it back to the same subscribers

The purpose of this node is to feed transforms to the resampler (that feeds them to the graph builder). The transforms all need to be formatted the same way and have consistent agent names between them (see example below). To do so, there is some work

**For apriltag transforms**:

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

**For odometry transforms**:

Upon receiving a odometry transform, we get the transform's following attributes:

- `header.frame_id`
- `header.child_frame_id`

The two are the same, since an odometry transform is just a transform between the autobot at time t1 and the autobot at time t2.

**Frames of reference and associated transformations**:

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

**The importance of time stamps**:

Each odometry or apriltag transform message comes with a timestamp. Since we want to track the movement in time of each autobot, those are very important to keep and transmit with the transform.

For things that don't move, e.g. the watchtowers and the apriltags that are not on autobots, we don't need to keep the timestamp. This only happens when the transform is from a `watchtower_camera` to an `apriltag_base` (which is not on an autobot).

**To conclude**:

The ROS listener makes sure to transmit transforms with the right frame ids (parent and child), to the right frames of reference (`autobot_base` for the autobots), with the right time stamps.

At the end of the pipeline, it receives back optimized estimates of the trajectories of the autobots and of the positions of the watchtowers. It then publishes them and stores them.

### The Resampler

**What is the resampler and why do we need it?**:

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



### The duckietown graph builder

### The g2o graph builder


## Trajectory extraction


