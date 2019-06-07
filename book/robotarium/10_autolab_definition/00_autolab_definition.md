# Autolab definition {#part:autolab-definition status=draft}

<div class='requirements' markdown="1">

Requires: A Duckietown up to specifications from [the duckietown book](+opmanual_duckietown#duckietowns).

Results: Knowledge of the fundamental structures that make an Autolab.

Next Steps: Building the [autocharging area](#part:autolab-auto-charging).
</div>

An Autolab is a Duckietown with a set of additional structures:

- A maintenance area
- A localization system
- An Autolab operation server

Similarly, the duckiebots that are used are called autobots and rely on additional specifications.

## The maintenance area

The maintenance area is an area that is designed to include all activities that are not related to the self driving goals of Duckietown.

Right now, it is only comprised of the [auto-charging area](#autolab-auto-charging), but could be extended to include for example:

- A parking lot
- An auto-calibration arena

It is accessed via a single entry point (see [](#fig:Autolab)).

This area is critical to the full automation of the Autolab, because it will allow for the autobots to go around indefinitely and go recharge on their own, without human intervention.

## The localization system

The [localization system](#autolab-localization) is comprised of a set of watchtowers distributed in the city and of a server to process the data and extract localization of all autobots. The stream of images from all watchtowers can be used in many other projects than autobot localization.

## The Autolab operation server

The Autolab operation server, described in the [autolab operation manual](#autolab-operation-manual) and currently under development, is and will be the human interface to control the high level functions of the Autolab, to monitor its status and activity, and to launch experiments.

<div figure-id="fig:Autolab">
<img src="images/autolab.png" style="width: 60%"/>
<figcaption>
Autolab example map
</figcaption>
</div>


**Keywords**: robotics, Autolab, auto-charging, charging, maintenance
