# Input processing {#localization-input-processing status=ready}

Excerpt: The pipeline to treat the raw input to the system and transform it for the graph.

<div class='requirements' markdown="1">

Requires: Knowing the type of [input to the system](#localization-input)

Results: Knowing how this input is processed for the localization graph
</div>

<minitoc/>

## Motivation

From [](#localization-input), we now know that we have many streams of image input, from both Watchtowers and Autobots. These images contain various Apriltags, that are placed and registered in the city as described in [](#localization-apriltags-specs).

These Apriltags need to be processed in order to feed the associated transforms to the graph builder. This means that on every image, for every Apriltag on the image, a transform is computed that links the `camera_frame` to the `apriltag_frame`, keeping in memory the name of the agent (Watchtower or Autobot) that detected the Apriltag, as well as the Apriltag unique ID, and the timestamp at which the image was taken. This package of information makes up what will be called everywhere **stamped transform**.

We also have the wheel commands streams of each Autobots. These need to be processed into **stamped transform** as well, as those are the only thing we want to feed the localization graph with.

Note: **Notation**: This parts receives **images** and **wheel commands** and outputs **stamped transforms** to the [ROS Listener](#localization-ros-listener).

## Apriltag detection strategies

Apriltag detection is very computationally expensive, and different strategies can be used:

* **Offline acquisition** : each agent just records the images, then they are gathered and processed later, offline, without any time requirement. This is the easy, but unsatisfactory way. This also means that the localization can only be used *a posteriori*, so it can not be used for real time decision making.
* **Online acquisition** : the images are processed during the experiment, and the graph and localization is done (with some delay) online. This is much *harder* to do as processing images is costly.

For **online acquisition**, three strategies can be used:

* Each agent tries to do the processing directly onboard and just sends the stamped transforms to a central ROS master that will do the graph
* Each agent directly sends the images and the central ROS master does the processing for every agent (this implies having a (or many) good computer)
* A mix of the two is also possible (the Autobots send their images, the Watchtowers process them)

As explained in [](#localization-demo), in both cases the Watchtowers and Autobots use the [acquisition bridge](#acquisition-bridge) to send their image streams to a central computer. The Watchtowers only send images when movements are detected, to reduce the number of images to process and record.

For offline acquisition, all we need to do is record a rosbag on this computer.

For online acquisition, the stream of data needs to be used directly by an apriltag extractor.

## Apriltag extraction

No matter how (or on which device) we get the image streams, we need to process them to get the stamped transforms of each Apriltag in each image.

### Offline case

For the *offline* case, where speed is not relevant, we get a rosbag from the recording. We feed this bag to a `post processor`, which code is in part 08 of the [cslam repository](https://github.com/duckietown/duckietown-cslam).

This code will run apriltag extraction as well as odometry processing and it will export all the corresponding stamped transforms to a new bag.

### Online case

For the *online* case, we cannot just use one container to do all the extraction. The current strategy is to instantiate one apriltag processor per Watchtower. Each processor is one container that only listens to the image topic of the Watchtower it was assigned to, and outputs the processed stamped transforms. The code is in part 04 of the [cslam repository](https://github.com/duckietown/duckietown-cslam). It is mainly exactly the same process as int the post processing container.

Todo: explain AT detection process and code, etc...

## Odometry processing (wheel odometry)

In the wheel odometry case, we can listen to the wheel command topic or get it from a rosbag (same process for offline/online as for the Apriltag detection).

But no matter the way we get the data, here is how we process it:

* An odometry message is received with timestamp `t1`.
* The next one is received with timestamp <code>`t2` > `t1` </code>.
* The wheel velocities are considered constant between `t1` and `t2`, with values from the odometry message at time `t1`.
* From the differential model of the Autobot, linear velocity `V_l` and angular velocity `Omega` can be computed
* From those constant velocities, the transform between `t1` and `t2` can be computed
* The transform is stamped with `t1` and with the Autobot's ID, which makes it a stamped transform, that is then sent to the localization graph.

### Future work

Right now, the [acquisition bridge](#acquisition-bridge) for Autobots sends the wheel commands, but future work could imply using more advanced modeling and system identification of the Autobots to output more accurate linear velocity `V_l` and angular velocity `Omega`. Then the above algorithm would just skip the phase where it transform the wheel commands into  `V_l` and `Omega`.

Todo: Actually give the equations
