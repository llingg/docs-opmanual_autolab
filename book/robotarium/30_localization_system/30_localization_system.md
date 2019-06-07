# Localization System {#part:autolab-localization status=draft}

The auto-localization system is an important part of the Autolab, as it gives the localization of all Autobots in the city to a server. In the Autolab, the Autobots are Duckiebots that have been improved to Autolab specifications (see [](#autolab-autobot-specs)).

Note: Watchtowers are an experimental feature of Duckietown, which are currently only used in Autolabs.

$~$

**Sections**

___

* [](#localization-watchtower-hardware): How to assemble watchtowers.
* [](#localization-apriltags-specs): The april tag specifications and measure.
* [](#localization-offline): The manual to run localization offline.
* [](#localization-online): The manual to run localization online.
* [](#light-sensors): The manual to use the lights sensors of the watchtowers.
* [](#localization-software): An overview of the localization code.

$~$

**Overview**

___
The localization system has multiple purposes: 

* Automating completely the Autolab:
  * It allows the central system to discover if a Autobot runs out of the track
  * It allows more high level fleet control
* It allows the grading of the embodied challenges for the AIDO competitions

The localization system mainly relies on Apriltags, which are a kind of QR code. Each Autobot is provided with a plate with an Apriltag on top. By tracking the Apriltags on Autobots, the system evaluates their poses.

To track the Apriltags, we use watchtowers. In the spirit of Duckietown, a watchtower uses the same hardware as a Duckiebot and is integrated with the city. Thus, we developed a little tower which is about 60cm in height. At the top of the tower, the  pi-camera looks over a part of the city. The watchtowers are spread all over the city, and by combining the field of view of each tower, it is possible to cover the whole Autolab.

$~$

**The Basic Concept of the System**
___


Todo: complete this part

$~$

**Hardware**
___

There are two structural elements to have a working system:

* The watchtowers
* The ground Apriltags

As explained before, the system is designed so that watchtowers don't need to be at a specific height or pose as long as they can see a sufficient field of view. However, we still provide the spec of the watchtowers so that one could produce watchtowers without testing field of view. See hardware part in chapter [](#localization-watchtower-hardware).

Moreover, the ground Apriltags need to follow conventions specified in the chapter [](#localization-apriltags-specs).


$~$

**Software Setup**
___


See software part in chapter [](#auto-localization-software)

$~$

**Steps of Running Auto-Localization**
___


See more about steps of running auto-localization system [](#auto-localization-operation-procedure)
