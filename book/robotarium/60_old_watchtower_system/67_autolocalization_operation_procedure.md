# Auto-Localization Operation Procedure {#auto-localization-operation-procedure status=beta}

TODO: Move this to the Autolab book.

TODO: add knowledge box

In this document, we wrote down the procedure of launching Auto-localization system.

## Overview

The purpose of this chapter is to guide all Autolab builders in the world to successfully launch the Auto-localization system.

The procedure including two part, map setup, system calibration and system localization The system calibration procedure should calculate and save the transformation matrices from local tags frame to the origin tag frame. The system localization procedure is simply the localization function.

## Map Setup

### Reference tag setup

There should be at least one reference tag in the field of views of each watchtowers. The reference tags could be traffic sign tags or any other tag placed in the field of view. The only thing to aware is to not place the very same tag in the city twice.

### Map file setup

You need to create your own map file to make the system work! Create a map file on your server computer.

    laptop $ cd ~/duckietown/catkin_ws/src/30-localization-and-planning/auto_localization/config
    laptop $ cp testcircle_origin(dontoverwrite).yaml ![your map].yaml

The `your map`.yaml is the map file for your Autolab, name it whatever you want. Edit `your map`, modify the id of `origin` to your origin tag id, and add all your watchtowers' hostnames to `watchtowers`.

## System Calibration

The below equation explained how to get the transformation matrix between reference tags and the origin tag.

TODO: Add equation

And this picture is a indication of how watchtowers form the equation above.

TODO: Add indication picture

Basically it means that we need to make `links` from reference tags to the origin tag. To do so, we need sufficient overlapping of field of view (we talked about that in previous chapter) and link tags at the overlapping area.

The link tags could be put at where they are needed and take away after system calibration.

After placing the tags, execute these commands on your server computer to start central server for TCP/IP. ![IP_address] should be the IP address of computer you wanna set it as server. ![your map] is the map file of your map.

    laptop $ make auto_localization_calibration_server IP:=![IP_address]

Open another terminal

    laptop $ make auto_localization_calibration_laptop IP:=![IP_address] map:=![your map]

Open another terminal and open ssh connections to all watchtowers through xpanes and tmux<!--[xpanes](#xpanes) and [tmux](#tmux)-->. Execute the command on watchtowers

    duckiebot $ make auto_localization_calibration_watchtower IP:=![IP_address]

After the server computer showing `calibration finished`, you could terminate all ros node with `ctrl` + `c`.

The calibration files which include tags id and transformation matrix will be saved in ![your map].yaml . If it shows `nah` after the transformation column of a tag, it means that there's no link from origin to the tag. You might need to adjust the placement of link tags or simply add more link tags. And redo the procedure.

You could remove linked tags (but not reference tags) afterwards.

## System Localization

First on your server computer, execute following commands. ![IP_address] should be the IP address of computer you wanna set it as server. ![your map] is the map file of your map.

    laptop $ make auto_localization_server IP:=![IP_address]

Open another terminal

    laptop $ make auto_localization_laptop IP:=![IP_address] map:=![your map]

Open another terminal and open ssh connections to all watchtowers through xpanes and tmux <!-- [xpanes](#xpanes) and [tmux](#tmux)-->. Execute the command on watchtowers

    duckiebot $ make auto_localization_watchtower IP:=![IP_address]

The system starts working. On server computer, the `~bot_global_poses` topic publishes Duckiebots' poses, reference tags it take reference to, and the camera that detect the Duckiebot.

The system also records all records under `config` folder with .csv file. You could checkout the performances of each Duckiebot in the file.

### Troubleshooting
