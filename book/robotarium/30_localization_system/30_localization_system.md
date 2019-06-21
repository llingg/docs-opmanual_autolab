# Localization System {#part:autolab-localization status=draft}

<div class='requirements' markdown="1">

Requires: A fully operational [Duckietown](+opmanual_duckietown#duckietowns)

Results: A working localization system to localize all duckiebots inside the Autolab

Next Steps: The first step is to build the [watchtowers](#localization-watchtower-hardware)
</div>


The localization system is an important part of the Autolab, as it gives the localization of all Autobots in the city to a server. In the Autolab, the Autobots are Duckiebots that have been improved to Autolab specifications (see [](#autolab-autobot-specs)).

Note: Watchtowers are an experimental feature of Duckietown, which are currently only used in Autolabs.


### Sections


* [](#localization-watchtower-hardware): How to assemble watchtowers. - OUTDATED
* [](#localization-apriltags-specs): The april tag specifications and measure. - TODO
* [](#localization-offline): The manual to run localization offline. - TODO
* [](#localization-online): The manual to run localization online. - TODO
* [](#light-sensors): The manual to use the lights sensors of the watchtowers. - TODO
* [](#localization-software): An overview of the localization code. - TODO


###Overview and Concept of the system

The localization system has multiple purposes: 

* Automating completely the Autolab:
  * It allows the central system to discover if a Autobot runs out of the track
  * It allows more high level fleet control
* It allows the grading of the embodied challenges for the AIDO competitions

The localization system mainly relies on Apriltags, which are a kind of QR code. Each Autobot is provided with a plate with an Apriltag on top. By tracking the Apriltags on Autobots, the system evaluates their poses.

To track the Apriltags, we use watchtowers. In the spirit of Duckietown, a watchtower uses the same hardware as a Duckiebot and is integrated with the city. Thus, we developed a little tower which is about 60cm in height. At the top of the tower, the  pi-camera looks over a part of the city. The watchtowers are spread all over the city, and by combining the field of view of each tower, it is possible to cover the whole Autolab.

Then, using other Apriltags that are on the ground, called ground Apriltags, for which we determine in advance the exact localization, we build a big graph of all the relative poses bewteen watchtowers and what they see. By running optimization on the graph, we merge the local influx of data from all agents into a global position graph of all agents, using the ground Apriltags as global fixed references.

###BUILDING - Hardware

There are two structural elements to have a working system:

* The watchtowers
* The ground Apriltags

As explained before, the system is designed so that watchtowers don't need to be at a specific height or pose as long as they can see a sufficient field of view. However, we still provide the spec of the watchtowers so that one could produce watchtowers without testing field of view. See hardware part in chapter [](#localization-watchtower-hardware).

Moreover, the ground Apriltags need to follow conventions specified in the chapter [](#localization-apriltags-specs).



###DEMOS - Running Localization

Localization can be run either online or offline.

Running localization _online_ means that the data is processed _during_ the experiment and the results can be vizualised with some delay. The demo is found at [](#localization-online)

Running localization _offline_ means that the data recorded but processed only _after_ the experiment. Thee demo is found at [](#localization-offline)

While the long term objective is to only do online localization, the offline localization has proved very usefull for AIDO, because it requires less computing power and depends less on the network.


###SOFTWARE - Description

The software is explained in detailed in chapter [](#localization-software)
