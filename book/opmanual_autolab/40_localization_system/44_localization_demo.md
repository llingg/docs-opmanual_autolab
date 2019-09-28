# DEMO - Localization {#localization-demo status=ready}

Excerpt: The manual to run localization offline or online. - TODO

<div class='requirements' markdown="1">

Requires: A fully operational [Duckietown](+opmanual_duckietown#duckietowns), compliant [autobots](#autolab-autobot-specs), [watchtowers](#watchtower-hardware) and a system of [ground April tags](#localization-apriltags-specs)

Results: running offline or online localization in the Autolab

Next Steps: Contribute to [localization software](#localization-software)
</div>

<minitoc/>


## Setting up your master computer

The localization pipeline needs a __master__ computer that will receive all information and process it. In order for everything to work, you need a kinetic roscore running at all times, and it needs to be run first.

    laptop $ docker run --name roscore --rm --net=host -dit duckietown/dt-ros-commons:daffy-amd64 roscore

If this container is stopped at some point, then all the acquisition bridges (see below) need to be restarted, as they need connection to this rosmaster.

## Setting up software on the watchtowers

In order to use the localization pipeline, you need to have two containers running on the watchtowers: 

- duckiebot-interface (a special version)
- acquisition-bridge

### The duckiebot-interface for watchtowers

The watchtowers need a slightly modified version of the duckiebot interface.

**The following commands should be run on every watchower**. If you named them with numbers (Watchtower01 to watchtowerXX), then you can easily make for loops in shell.

First, remove the duckiebot interface that is running:

    laptop $ docker -H ![hostname].local rm -f dt18_03_roscore_duckiebot-interface_1

Then, pull the custom image

    laptop $ docker -H ![hostname].local pull duckietown/duckiebot-interface:daffy-arm32v7

Then, launch it:

    laptop $ docker -H ![hostname].local run --name duckiebot-interface --privileged -e ROBOT_TYPE=watchtower --restart unless-stopped -v /data:/data -dit --network=host duckietown/duckiebot-interface:daffy-arm32v7

### The acquisition-bridge for watchtowers

In order to get the images from all watchtowers to the same rosmaster (your computer), we launch an acquisition bridge, whose role for the watchtowers is to publish camera image and camera information, but only when movement is detected. This way, we only get the data that is needed for localization.

To run this, please run on all watchtowers:

    laptop $ docker -H ![hostname].local run --name acquisition-bridge --network=host -e ROBOT_TYPE=watchtower -dit duckietown/acquisition-bridge:daffy-arm32v7

### Advice

Always leave your roscore running, and always leave the duckiebot-interface and the acquisition-bridge of the watchtowers running. This will make all subsequent processes much faster to launch.

## Setting up software on the duckiebots

The duckiebots require the same two containers, duckiebot-interface and acquisition-bridge.

### The acquisition bridge for duckiebots

The default duckiebot-interface is good enough for the duckiebots, so we will just add the acquisition-bridge.

On all duckiebots please run:

    laptop $ docker -H ![hostname].local run --name acquisition-bridge --network=host -v /data:/data -dit duckietown/acquisition-bridge:daffy-arm32v7

## Checking if the acquisition bridges work

On your PC, you should now be able to get the image stream of all connected duckiebots, using rqt_image_view.

If you have ubuntu18 with melodic, rqt_image_view might not show the images. If so, use:

    laptop $ dts start_gui_tools ![PC_name]

Then run rqt_image_view from there.

## Offline localization

The offline localization is offline in the meaning that you only get a trajectory of your duckiebots after the experiment is over. 
The process is the following:

- You record an experiment
- You process the bag you get to extract apriltag poses and odometry
- You run the graph optimizer on this intermediary result and it gives you the trajectory of all duckiebots in yaml files.

### Recording the experiment

When you are ready to start an experiment, on your master PC, run rosbag:

    laptop $ rosbag record -a -O ![BAG_NAME.BAG]

and stop it at the end of the experiment.

### Processing the apriltags and odometry from the bag

First, you need to know where your bag is. The folder containing it is referred as `PATH_TO_BAG_FOLDER` in the following. We recommend you create new separate folders for each experiment (with date and/or sequence number).

    laptop $ docker run --name post_processor -dit --rm -e INPUT_BAG_PATH=/data/![BAG_NAME.BAG] -e OUTPUT_BAG_PATH=/data/processed_![BAG_NAME.BAG] -e ROS_MASTER_URI=http://![YOUR_IP]:11311 -v ![PATH_TO_BAG_FOLDER]:/data duckietown/post-processor:daffy-amd64

When the container stops, then you should have a new bag called `processed_BAG_NAME.BAG` inside of your `PATH_TO_BAG_FOLDER`.

### Launching the graph optimizer

    laptop $ docker run --rm  -e  ATMSGS_BAG=/data/processed_![BAG_NAME.BAG] -e OUTPUT_DIR=/data -e ROS_MASTER_URI=http://![YOUR_IP]:11311 --name graph_optimizer -v ![PATH_TO_BAG_FOLDER]:/data duckietown/cslam-graphoptimizer:daffy-amd64

The poses can then be visualized in Rviz as the optimization advance.

The trajectories will be stored in the folder `PATH_TO_BAG_FOLDER`.

Todo: add better visualization tools

## Online Localization

Note: This is highly experimental, as up until now the processing power required to run localization online is really heavy. The goal of the current development is to make the process affordable for a single computer

Online localization is the idea of running an experiment and getting (with a reasonable delay) the localization and path of each duckiebot
The processing bottle neck is on the processing of the April tags from the watchtower images.

Normally, at this point, you should have a duckiebot-interface and a acquisition bridge on each device (duckiebot and watchtower).

### Online processing

TODO: give instructions

### Localization

Once the online processing is started (or even before), run:

    laptop $ docker run --rm -e OUTPUT_DIR=/data -e ROS_MASTER_URI=http://![YOUR_IP]:11311 --name graph_optimizer -v ![PATH_TO_RESULT_FOLDER]:/data duckietown/cslam-graphoptimizer:daffy-amd64

The `PATH_TO_RESULT_FOLDER` folder is the one where the results will be saved in yaml files at the end of the experiment, when you CTRL+C the above command


