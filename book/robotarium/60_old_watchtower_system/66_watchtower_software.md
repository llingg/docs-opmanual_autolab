# Auto-Localization Software Preparation {#auto-localization-software status=outdated}

Here we demonstrated how to prepare the Duckietown software on watchtowers for auto-localization function.

## Overview

This chapter will guild you through the preparation of Duckietown software on watchtower. Most of them are the same as preparing for a Duckiebot. Therefore, it'll be a piece of cake for most of you.

## Duckietown repository setup

Please follow Duckiebot operational manual from A-10.1 to 10.5. Of course you don't need to do the parts regards to joystick control. (Unless you want a "mobility watchtower".) <!-- See:[](#setup-duckiebot) --> See setup-duckiebot

If you name your watchtower with **mom**@**watchtowerXX** where XX is 01 to 50. We have prepared the robot yaml file in duckiefleet repo under devel-auto-localization branch, folder robots/zurich/watchtower. Therefore you could checkout this branch instead of create machine files yourself.

Further more, since we're preparing **50** or even more watchtowers, we recommended that you use xpanes and tmux to prepare 50 at the same time.

<!-- See:[](#tmux) -->

See tmux

<!-- See:[](#xpanes) -->

see xpanes

## Auto-localization function setup

Once Duckietown and Duckiefleet repo are set. Checkout auto-localization branch.

    duckiebot $ cd ~/duckietown
    duckiebot $ git checkout devel-auto-localization-system-calibration

Next, we need to compile the workspace.

    duckiebot $ catkin_make -C catkin_make

Please make the workspace until it's 100%. If it doesn't get to 100% at the first time, do catkin_make again until it's complete.


## Camera Calibration

Unfortunately there's no "magic trick" at the moment to bypass calibrating 50 cameras one by one. Please see camera calibration chapter.

<!-- See: [](#camera-calib-old) -->

See camera-calib-old

Please note that, it's better to be more precise when doing localization. Thus, please fill in the green bar as much as you could. It's know that it's possible to completely fill up "x", "y", "skew" bar and about 70% fill up for "size" bar.

TODO: Add a picture of calibration.

After all calibration, remember to push your work to duckiefleet repo.

### Troubleshooting

Symptom: ImportError: No module name networkx.algorithms.dag

Resolution: We could manually install them by pip install.

    duckiebot $ pip install --user networkx

Symptom: Unsupported `locale` problem

Solution: Set up the locale by these commands

    duckiebot $ export LC_ALL="en_US.UTF-8"
    duckiebot $ export LC_CTYPE="en_US.UTF-8"
    duckiebot $ export LANGUAGE="en_US.UTF-8"
    duckiebot $ export LANG="en_US.UTF-8"
    duckiebot $ sudo dpkg-reconfigure locales

press **ok** and choose en_US.UTF-8.

Symptom: No module name `geometry`

Resolution: Do this command under duckietown folder again

    duckiebot $ /bin/bash ./dependency_for_duckiebot.sh
