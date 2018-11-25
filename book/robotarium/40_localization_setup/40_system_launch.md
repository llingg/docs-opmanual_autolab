# System Launch {#autolocalization-system_launch status=beta}

In this document, we wrote down the procedure of launching Auto-localization system.

## Overview

The purpose of this chapter is to guide all robotarium builders in the world to successfully launch the Auto-localization system.

The procedure including two part, map setup, system calibration and system localization The system calibration procedure should calculate and save the transformation matrixes from local tags frame to the origin tag frame. The system localization procedure is simply the localization function.

## Map Setup

### Reference tag setup

There should be at least one reference tag in the field of views of each watchtowers. The reference tags could be traffic sign tags or we could put tags there. The only thing to aware is that don't out a tag in the city twice.

### Map file setup

You need to create your own map file to make the system work! Create a map file on your server computer.

    laptop $ cd ~/duckietown/catkin_ws/src/30-localization-and-planning/auto_localization/config
    laptop $ cp testcircle_origin(dontoverwrite).yaml ![your map].yaml

The `your map`.yaml is the map file for your robotarium, name it whatever you want.

Edit `your map`, what you have to do are
  1. Modify the id of `origin` to your origin tag id
  2. Add **ALL** your watchtowers' hostnames to `watchtowers`, in the system calibration the server computer will wait until all watchtower send tag informations.
  3. Build up your map. Edit `tiles` to the configuration of your map.

You don't need to modify anything under "fixed_tags", which store the transformation matrix of each reference tags to the origin tag. The system calibration step will do that for you!.

_The default map for localization system is None. You need to specify the map each time._

_The default map for system calibration is testcircle.yaml_

## System calibration (Automatically)

To perform auto-localization, we need to know the transformation between local frame and the global frame . Of course one could enter the pose of each tag hand-by-hand, but that will be pretty annoying and inefficient. Here we introduce a tool that could calibrate the whole system, provide the transformation of each tag and save them to and yaml file for future usage.

- Advantages: It saves time from putting and setting reference tags.
- Disadvantages: It's still not that accurate.

### Before Calibration

The system calibration require the reference tags to be linked to the origin tag. Thus, we might need to put some "linked" tag to make the graph complete. The linked tags are suggested to be put in the overlap region of watchtowers so that they really achieve their function.

<figure>
    <p align="center">
      <img style="width:30em" src="images/linked_tag.png"/>
      <figcaption>The orange area is the rough field of view if the upper left watchtower. The blue are is the rough field of view of the lower left watchtower. The circled tag thus serve as a "linked tag which connect tags between these two watchtowers"</figcaption>
    </p>
</figure>

The only constraint of putting the linked tag is that don't use the tags that have been used in the town. Always make sure you don't use the same tag twice.

### Calibration

Execute these commands on your server computer (could be your laptop) to start central server for TCP/IP.

![IP_address] is the IP address of computer you wanna set it as server.

![your map] is the map file of your map.

    server $ make auto_localization_calibration_server IP:=![IP_address]

Open a terminal on your laptop, start calibration procedure on your laptop.

    laptop $ make auto_localization_calibration_laptop IP:=![IP_address] map=![your map]

Open ssh connections to all watchtowers through  [xpanes](https://github.com/greymd/tmux-xpanes)  and  [tmux](https://gist.github.com/MohamedAlaa/2961058)  . Execute the command on watchtowers

    watchtowers $ make auto_localization_calibration_watchtower IP:=![IP_address]

<figure>
    <p align="center">
      <img style="width:30em" src="images/calibration_gui.png"/>
      <figcaption>This is the GUI of calibration. Each little square shows the number of watchtower and the tags that seen by the watchtower. Different column in the left panel imply the different level in the link. The numbers behind each level are the tags that seen by the level. The lower right panel shows watchtowers that have not been in the link. If the number of tag is shown in red, it means that the other way of transformatino has not been received yet. (i.e. The system gets the transformation from A to B but has no transformation from B to A).</figcaption>
    </p>
</figure>

### Result of System Calibration

  You can find a file called `map_name_date_and_time.yaml` in folder auto_localization/config. This is the map you should use while performing localization which included the transformation matrix of tags.

### Some more explanation about System Calibration

The system calibration require the reference tags to be linked to the origin tag.

## System calibration (Manually)

Another way is to put reference tags set there pose manually. We recommend to put two tags per watchtower. Also the tags should be put on the ground.

- Advantages: It is more accurate than done automatically.
- Disadvantages: It takes some time to put and set reference tags.

First, put at least one (we recommend two) reference tags in the view of an watchtower. While putting the tags, set the pose of each tags to your map file.

You can follow this [format](https://github.com/duckietown/Software/blob/devel-auto-localization-julian/catkin_ws/src/30-localization-and-planning/auto_localization/config/eth_robotarium_test.yaml)  and learn how to set the pose of reference tags.

In the `id` column, you should put the ID of the tag. In the `orientation` and `translation` row, you should set the pose (unit: degree and centimeters) of the tag with respect to _the tile you put the tag_. In the `tile` column, set where the tile is correspond to the while map with the `(0, 0)` tile is the most bottom left one, the `(1, 0)` is on the right of the `(0, 0)` and the `(0, 1)` is above the `(0, 0)`.

You will probably knows that the format is a bit different from the automatically one. But don't worry, the node will deal with that, just launch the system as usual.

After calibration, use this map file directly for localization.

<figure>
    <p align="center">
      <img style="width:30em" src="images/tags.jpg"/>
      <figcaption>This is the GUI of auto-localization. The configuration of the map can be modify in map.yaml file. The blue things in the map is a Duckiebot. The size of the circle implies the deviation of the position. The direction of the arc implies the direction of the Duckiebot. The angle of the arc implies the deviation of the orientation.</figcaption>
    </p>
</figure>

## System Localization

First on your server computer (could be your laptop), execute following commands.

![IP_address] should be the IP address of computer you wanna set it as server.

![your map] is the map file of your map.

    server $ make auto_localization_server IP:=![IP_address]

Open a terminal on your laptop, start localization procedures on your laptop

    laptop $ make auto_localization_laptop IP:=![IP_address] map=![your map]

Open ssh connections to all watchtowers through [xpanes](#xpanes) and [tmux](#tmux). Execute the command on watchtowers

    watchtower $ make auto_localization_watchtower IP:=![IP_address]

<figure>
    <p align="center">
      <img style="width:30em" src="images/local_gui.png"/>
      <figcaption>This is the GUI of auto-localization. The configuration of the map can be modify in map.yaml file. The blue things in the map is a Duckiebot. The size of the circle implies the deviation of the position. The direction of the arc implies the direction of the Duckiebot. The angle of the arc implies the deviation of the orientation.</figcaption>
    </p>
</figure>

It tells

In general data
- Number of Duckiebots in the map
- Number of watchtwers operating in the map
- The now time stamp
- Unit of pose

In robot data (once click on one of the robot)
- The id of the Duckiebot
- The difference between the time of the detection (in the past) with the time stamp now.
- Position of the Duckiebot / deviation of the position
- Orientation of the Duckiebot / deviation of the orientation
- The watchtowers that saw the Duckiebot

### System Localization Output

#### Topic

The system starts working. On laptop, the `~bot_global_optimizae_poses` topic publishes Duckiebots' poses, reference tags it take reference to, and the camera that detect the Duckiebot.

#### Result file

The system also records all records under `auto_localization/config` folder with .csv file. You could checkout the performances of each Duckiebot in the file.

The result before and after optimization are all saved.

## Development

For more informations about the topics and nodes, please visit the repo.

See: [devel-auto-localization](https://github.com/duckietown/Software/tree/devel-auto-localization/catkin_ws/src/30-localization-and-planning/auto_localization)

### Troubleshooting
