# DEMO - Localization offline {#localization-offline status=draft}

<div class='requirements' markdown="1">

Requires: A fully operational [Duckietown](+opmanual_duckietown#duckietowns), compliant [autobots](#autolab-autobot-specs), [watchtowers](#watchtower-hardware) and a system of [ground april tags](#localization-apriltags-specs)

Results: running offline localization in the Autolab

Next Steps: Run [online localization](#localization-online)
</div>

## Setting up your master computer

The localization pipeline needs a __master__ computer that will receive all information and process it. In order for everything to work, you need a kinetic roscore running at all times, and it needs to be run first.

    laptop $ docker run --name roscore --rm --net=host -dit duckietown/dt-ros-commons:master19-amd64 roscore

If this container is stopped at some point, then all the acquisition bridges (see below) need to be restarted, as they need connection to this rosmaster.

## Setting up software on the watchtowers

In order to use the localization pipeline, you need to have two containers running on the watchtowers: 

- duckiebot-interface (a special version)
- acquisition-bridge

### The duckiebot-interface for watchtowers

The watchtowers need a slightly modified version of the duckiebot interface.

The following commands should be run on every watchower. If you named them with numbers (Watchtower01 to watchtowerXX), then you can easily make for loops in shell.

First, remove the duckiebot interface that is running:

    laptop $ docker -H ![hostname].local rm -f dt18_03_roscore_duckiebot-interface_1

Then, pull the custom image

    laptop $ docker -H ![hostname].local pull duckietown/duckiebot-interface:master19-watchtower

Then, launch it:

    laptop $ docker -H ![hostname].local run --name duckiebot-interface --privileged --restart unless-stopped -v /data:/data -dit --network=host duckietown/duckiebot-interface:master19-watchtower

### The acquisition-bridge for watchtowers

In order to get the images from all watchtowers to the same rosmaster (your computer), we launch an acquisition bridge, whose role for the watchtowers is to publish camera image and camera information, but only when movement is detected. This way, we only get the data that is needed for localization.

To run this, please run on all watchtowers:

    laptop $ docker -H ![hostname].local run --name acquisition-bridge --network=host -dit duckietown/acquisition-bridge:master19-arm32v7-watchtower

### Advice

Always leave your roscore running, and always leave the duckiebot-interface and the acquisition-bridge of the watchtowers running. This will make all subsequent processes much faster to launch.

## Setting up software on the duckiebots

The duckiebots require the same two containers, duckiebot-interface and acquisition-bridge. 

### The acquisition bridge for duckiebots

The default duckiebot-interface is good enough for the duckiebots, so we will just add the acquisition-bridge.

On all duckiebots please run:

    laptop $ docker -H ![hostname].local run --name acquisition-bridge --network=host -dit duckietown/acquisition-bridge:master19-arm32v7-autobot

## Checking if the acquisition bridges work

On your PC, you should now be able to get the image stream of all connected duckiebots, using rqt_image_view.

If you have ubuntu18 with melodic, rqt_image_view might not show the images. If so, use:

    laptop $ dts start_gui_tools ![PC_name]

Then run rqt_image_view from there.

## Offline localization 

### Recording the experiment

When you are ready to start an experiment, on your master PC, run rosbag:

    laptop $ rosbag record -a -O ![bag_name.bag]

and stop it at the end of the experiment.

### Processing the apriltags and odometry from the bag

First, you need to know where your bag is. The folder containing it is referred as ![PATH_TO_BAG_FOLDER] in the following. We recommend you create new seperate folders for each experiment (with date and/or sequence number).

    laptop $ docker run --name post_processor -dit --rm -e INPUT_BAG_PATH=/data/![bag_name.bag] -e OUTPUT_BAG_PATH=/data/processed_![bag_name.bag] -e ROS_MASTER_URI=http://![YOUR_IP]:11311 -v ![PATH_TO_BAG_FOLDER]:/data duckietown/post-processor:master19-amd64

When the container stops, then you should have a new bag called processed_![bag_name.bag] inside of your ![PATH_TO_BAG_FOLDER].

### Launching the graph optimizer

    laptop $ docker run --rm  -e  ATMSGS_BAG=/data/processed_![bag_name.bag] -e OUTPUT_DIR=/data -e ROS_MASTER_URI=http://![YOUR_IP]:11311 --name graph_optimizer -v ![PATH_TO_BAG_FOLDER]:/data duckietown/post-processor:master19-amd64

The poses can then be visualized in Rviz.

Todo: add better visualization tools
