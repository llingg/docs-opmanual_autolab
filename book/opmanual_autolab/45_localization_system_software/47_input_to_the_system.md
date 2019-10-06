
# Input to the system {#localization-input status=ready}

Excerpt: The input data fed to the localization system

<!-- <div class='requirements' markdown="1">

Requires: 

Results: 
</div> -->

<minitoc/>


## Images from the Autobots

The Autobots already use a camera feed that is medium quality on the normal pipeline (640x480). All we do here is use the same image stream.

## Images from the Watchtowers

For the Watchtowers it is a different story. As it is not used (yet) for anything else, we decided for the below reason to use a better image resolution (1296x972) and a higher shutter speed:

* The cameras are high, so the relative size of the Apriltags is small, so higher resolution mean better detection of the Apriltags (especially on the edges of the image)
* The Autobots are (mostly) always moving, and this creates blur with the default shutter speed. With a higher shutter speed, the blur is decreased, and the resulting loss of light is barely noticeable.

Todo: add images to see the difference

## Odometry data from the Autobots

Here there are (at least) two options, but the result must be the same: What is needed is an odometry stream input.

An odometry input is a sequence of relative transform from position at time `t` to position at time  `t+dt` of the Autobot, with `dt` being the sampling time.

The currently available options are :

* Wheel command odometry : From the command input of the wheel we construct the odometry
* Visual odometry : From the image stream of the duckiebot we construct odometry

Let's discuss the pros and cons of each method.

### The wheel command odometry

Note : Right now, this is the used method

**The pros:**

* Very easy and fast to compute
* Can be done in real time
* The data is small to store and to transmit over network
* Is compliant with the dynamics model (no Y or Z velocity)
* Can use any identified model of the Autobot (gain-trim, kinematic, dynamic)

**The cons:**

* It is an input based odometry : very small worth
* Doesn't account for slipping (if the autobot is stuck but the wheels spin, the odometry continues to believe in forward movement)
* Has only been used with the simple and inaccurate gain-trim model

### The visual odometry

Note : Right now, this is not used, but it would be preferable in the long term

**The pros:**

* Relies on actual output data
* Will easily account for slipping, as the image won't change
* Many libraries exist that can be used

**The cons:**

* Very slow to process
* Impossible to run real time on an Autobot
* Does not take dynamic model into account, which can generate noise on Y and Z velocities (but to be fair this could be then be ignored)
* No library has actually been extensively tested on Autobots.
