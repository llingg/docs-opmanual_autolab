# Software Set Up {#autolocalization-software status=beta}

Here we demonstrated how to prepare the Duckietown software on watchtowers for auto-localization function.

## Overview

This chapter will guild you through the preparation of Duckietown software on watchtower. Most of them are the same as preparing for a Duckiebot. Therefore, it'll be a piece of cake for most of you.

## Duckietown repository setup

Please follow Duckiebot operational manual. Of course you don't need to do the parts regards to joystick control. (Unless you want a "mobile watchtower".)

If you name your watchtower with `mom`@`watchtowerXX` where XX is 01 to 50. We have prepared the robot yaml file in duckiefleet repo under devel-auto-localization branch, folder robots/zurich/watchtower. Therefore you could checkout this branch instead of creating machine files yourself.

Further more, since we're preparing _50_ or even more watchtowers, we recommended that you use xpanes and tmux to prepare 50 at the same time.

See: [tmux](https://gist.github.com/MohamedAlaa/2961058)

See: [xpanes](https://github.com/greymd/tmux-xpanes)

## Auto-localization function setup

Once Duckietown and Duckiefleet repo are set. Checkout auto-localization branch.

    watchtower $ cd ~/duckietown
    watchtower $ git checkout devel-auto-localization

Next, we need to compile the workspace.

    watchtower $ catkin_make -C catkin_make

Please make the workspace until it's 100%. If it doesn't get to 100% at the first time, do catkin_make again until it's complete.


## Camera Calibration

Unfortunately there's no "magic trick" at the moment to bypass calibrating 50 cameras one by one. Please see camera calibration chapter.

Please note that, it's better to be as precise as possible when doing localization. Thus, please fill in the green bar as much as you could. It's know that it's possible to completely fill up "x", "y", "skew" bar and about 70% fill up for "size" bar.

TODO: Add a picture of calibration.

After all calibration, remember to push your work to duckiefleet repo.

### Troubleshooting

Symptom: ImportError: No module name networkx.algorithms.dag

Resolution: We could manually install them by pip install.

    watchtower $ pip install --user networkx

Symptom: Unsupported `locale` problem

Resolution: Set up the locale by these commands

    watchtower $ export LC_ALL="en_US.UTF-8"
    watchtower $ export LC_CTYPE="en_US.UTF-8"
    watchtower $ export LANGUAGE="en_US.UTF-8"
    watchtower $ export LANG="en_US.UTF-8"
    watchtower $ sudo dpkg-reconfigure locales

press **ok** and choose en_US.UTF-8.

Symptom: No module name `geometry`

Resolution: Do this command under duckietown folder again

    watchtower $ /bin/bash ./dependency_for_duckiebot.sh
