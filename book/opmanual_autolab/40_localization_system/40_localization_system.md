# Localization System {#part:autolab-localization status=beta}

<div class='requirements' markdown="1">

Requires: A fully operational [Duckietown](+opmanual_duckietown#duckietowns)

Results: A working localization system to localize all Autobots inside the Autolab

Next Steps: The first step is to build the [Watchtowers](#watchtower-hardware)
</div>


The localization system is an important part of the Autolab, as it gives the poses of all Autobots in the city to a server. In the Autolab, the Autobots are Duckiebots that have been improved to Autolab specifications (see [](#autolab-autobot-specs)).

Note: Watchtowers are an experimental feature of Duckietown, which are currently only used in Autolabs.


### Sections


* [](#localization-watchtower-placement): How to place the Watchtowers in the city. - TODO
* [](#localization-apriltags-specs): The AprilTag specifications and measure. - TODO
* [](#localization-offline): The manual to run localization offline. - TODO
* [](#localization-online): The manual to run localization online. - TODO
* [](#light-sensors): The manual to use the light sensors of the Watchtowers. - TODO
* [](#localization-software): An overview of the localization code. - TODO


###Overview and Concept of the system

The localization system serves multiple purposes:

* Automating the Autolab completely:
  * It allows the central system to discover if a Autobot moves out of the track
  * It allows more high level fleet control
* It allows the grading of the embodied challenges for AIDO

The localization system mainly relies on AprilTags, which are a conceptually and visually similar to QR codes. Each Autobot is provided with a mounting plate with an AprilTag on top. By tracking these mounted AprilTags, the system evaluates the Autobot poses by solving an optimization problem.

To track the AprilTags, we use Watchtowers. In the spirit of Duckietown, a Watchtower uses most of the same hardware and software as a Duckiebot. A Watchtower is essentially a little tower which is about 60cm in height, and has a pi-camera at the top to look over a part of the city. The Watchtowers are spread all over the city, and by combining the field of view of each tower, it is possible to cover the whole Autolab.

Apart from AprilTags on Autobots, there are other AprilTags that are on the ground, called Ground AprilTags. The precise location for each Ground AprilTag is known in advance. We build a pose graph of all the relative poses bewteen Watchtowers and Autobots, and what they see. By running optimization on the graph, we merge the local influx of data from all agents into a global position graph of all agents, using the Ground AprilTags as global fixed references.

###BUILDING - Hardware

There are two structural elements required to have a working system:

* The Watchtowers
* The ground AprilTags

The localization system is designed such that Watchtowers don't need to be at a specific height or position as long as they can view "sufficient" area of the Autolab. (TODO: specify what "sufficient" means) However, we still provide the specs of the Watchtowers so that you can produce your own Watchtowers. See hardware part in chapter [](#watchtower-hardware).

Moreover, the ground AprilTags need to follow conventions specified in the chapter [](#localization-apriltags-specs).



###DEMOS - Running Localization

Localization can be run either online or offline.

Running localization _online_ means that the data is processed _during_ the experiment and the results can be vizualised with some delay. The demo is found at [](#localization-online)

Running localization _offline_ means that the data recorded but processed only _after_ the experiment. The demo is found at [](#localization-offline)

While the long term objective is to only do online localization, the offline localization has proved very useful for AIDO, because it requires less computing power and does not have the network bandwidth as a bottleneck.


###SOFTWARE - Description

The software is explained in detailed in chapter [](#localization-software)
