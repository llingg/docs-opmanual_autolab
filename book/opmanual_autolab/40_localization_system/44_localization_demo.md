# DEMO - Localization {#localization-demo status=ready}

Excerpt: The manual to run localization offline or online. - TODO

<div class='requirements' markdown="1">

Requires: A fully operational [Duckietown](+opmanual_duckietown#duckietowns), compliant [autobots](#autolab-autobot-specs), [watchtowers](#watchtower-hardware) and a system of [ground April tags](#localization-apriltags-specs)

Results: running offline or online localization in the Autolab

Next Steps: Contribute to [localization software](#autolab-localization-software)
</div>

<minitoc/>


## Setting up your master computer

The localization pipeline needs a __master__ computer that will receive all information and process it. In order for everything to work, you need a kinetic roscore running at all times, and it needs to be run first.

    laptop $ docker run --name roscore --rm --net=host -dit duckietown/dt-ros-commons:daffy-amd64 roscore

If this container is stopped at some point, then all the acquisition bridges (see below) need to be restarted, as they need connection to this rosmaster.

## Setting visualization (optionnal)

To set up an rviz visualization, run first :

    laptop $ xhost +

Then, remembering the fork of duckietown-world on which your map is, and remembering the name of the map, run:

    laptop $ docker run -it --rm --net=host --env="DISPLAY" -e ROS_MASTER=![COMPUTER_HOSTNAME] -e ROS_MASTER_IP=![COMPUTER_IP] -e DUCKIETOWN_WORLD_FORK=![YOUR_FORK] -e MAP_NAME=![YOUR_MAP] duckietown/dt-autolab-rviz

This should first show just the map with the tiles. When the graph optimizer runs (later down), the position that are calculated will show on this visualization.

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

    laptop $ docker -H ![hostname].local pull duckietown/dt-duckiebot-interface:daffy-arm32v7

Then, launch it:

    laptop $ docker -H ![hostname].local run --name duckiebot-interface --privileged -e ROBOT_TYPE=watchtower --restart unless-stopped -v /data:/data -dit --network=host duckietown/dt-duckiebot-interface:daffy-arm32v7

### The acquisition-bridge for watchtowers

In order to get the images from all watchtowers to the same rosmaster (your computer), we launch an acquisition bridge, whose role for the watchtowers is to publish camera image and camera information, but only when movement is detected. This way, we only get the data that is needed for localization.

To run this, please run on all watchtowers:

    laptop $ docker -H ![hostname].local run --name acquisition-bridge --network=host -e ROBOT_TYPE=watchtower -e LAB_ROS_MASTER_IP=![YOUR_ROS_MASTER_IP] -dit duckietown/acquisition-bridge:daffy-arm32v7

### Advice

Always leave your roscore running, and always leave the duckiebot-interface and the acquisition-bridge of the watchtowers running. This will make all subsequent processes much faster to launch.

## Setting up software on the duckiebots

The duckiebots require the same two containers, duckiebot-interface and acquisition-bridge.

### The acquisition bridge for duckiebots

The default duckiebot-interface is good enough for the duckiebots, so we will just add the acquisition-bridge.

On all duckiebots please run:

    laptop $ docker -H ![hostname].local run --name acquisition-bridge --network=host -v /data:/data -e LAB_ROS_MASTER_IP=![YOUR_ROS_MASTER_IP] -dit duckietown/acquisition-bridge:daffy-arm32v7

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

Remember from [](#autolab-map-making) that you created a map. Now is the time to remember on which fork you pushed it (the default is `duckietown`), and what name you gave to your map. The map file needs to be in the same folder as the rest of the maps. They are respectively the YOUR_FORK_NAME and YOUR_MAP_NAME arguments in the following command line.

To run localization, execute:

    laptop $ docker run --rm  -e  ATMSGS_BAG=/data/processed_![BAG_NAME.BAG] -e OUTPUT_DIR=/data  ROS_MASTER=![YOUR_HOSTNAME] -e ROS_MASTER_IP=![YOUR_IP] --name graph_optimizer -v ![PATH_TO_BAG_FOLDER]:/data -e DUCKIETOWN_WORLD_FORK=![YOUR_FORK_NAME] -e MAP_NAME=![YOUR_MAP_NAME] duckietown/cslam-graphoptimizer:daffy-amd64

The poses can then be visualized in Rviz as the optimization advance.

The trajectories will be stored in the folder `PATH_TO_BAG_FOLDER`.



## Online Localization

Note: This is highly experimental, as up until now the processing power required to run localization online is really heavy. The goal of the current development is to make the process affordable for a single computer

Online localization is the idea of running an experiment and getting (with a reasonable delay) the localization and path of each duckiebot
The processing bottle neck is on the processing of the April tags from the watchtower images.

Normally, at this point, you should have a duckiebot-interface and a acquisition bridge on each device (duckiebot and watchtower).

### Online processing

For each Watchtower that is running do on your computer :

    laptop $ docker run --name apriltag_processor_![WATCHTOWER_NUMBER] --network=host -dit --rm  -e ROS_MASTER_URI=http://![YOUR_IP]:11311 -e ACQ_DEVICE_NAME=![WATCHTOWER_NAME] duckietown/apriltag-processor:daffy-amd64

Where `WATCHTOWER_NUMBER` is just 01 to XX and `WATCHTOWER_NAME` is the hostname of the Watchtower (usually it is `watchtowerXX`).

For each Autobot that is running do on your computer :

    laptop $ docker run --name odometry_processor_![AUTOBOT_NUMBER] --network=host -dit --rm  -e ACQ_ROS_MASTER_URI_SERVER_IP=![YOUR_IP] -e ACQ_DEVICE_NAME=![AUTOBOT_NAME] duckietown/wheel-odometry-processor:daffy-amd64

Where `AUTOBOT_NUMBER` is just 01 to XX and `AUTOBOT_NAME` is the hostname of the Autobot (usually it is `autobotXX`).

Warning: The processing of apriltags is very heavy. Putting more than 4 processors on a computer is very risky. What you can do is use other computers that are on the same network. Launch exactly the same command and be sure to leave the IP of the designated master computer.

### Localization

Once the online processing is started (or even before), run:

    laptop $ docker run --rm -e OUTPUT_DIR=/data -e ROS_MASTER=![YOUR_HOSTNAME] -e ROS_MASTER_IP=![YOUR_IP] --net=host --name graph_optimizer -v ![PATH_TO_RESULT_FOLDER]:/data -e DUCKIETOWN_WORLD_FORK=![YOUR_FORK_NAME] -e MAP_NAME=![YOUR_MAP_NAME] duckietown/cslam-graphoptimizer:daffy-amd64

The `PATH_TO_RESULT_FOLDER` folder is the one where the results will be saved in yaml files at the end of the experiment, when you CTRL+C the above command to finish.


## Visualize the trajectories

After the localization is done (either offline or online), you can visualize the trajectory
of each Autobot superimposed to your map using a jupyter notebook in the duckietown-world repository.
Similarly to [](#autolab-map-making), launch `jupiter notebook` and open your browser.
Navigate to `notebooks` and open the notebook `65-Localization-ShowTrajectory`.
Change the values in the first block of this notebook to reflect the name of your map,
the location of your trajectory files within the file system, and the name of the Autobot to show.

Run all the cells, the last one will produce a picture of your map with the location of the
Autobot at time `t=0` and a slider to adjust the time.
