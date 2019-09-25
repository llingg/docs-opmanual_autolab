# Autolab operation manual {#part:autolab-operation-manual status=ready}

<div class='requirements' markdown="1">

Requires: Server for hosting the managment interface

Requires: [Localization system](#part:autolab-localization)

Results: Semi-autonomous lab to evaluate different algorithms on a fleet of Duckiebots

Next Steps: Offer your Autolab services to evaluate AIDO submissions
</div>

The Autolab Control System automates the operation of a Duckietown. Features include an overview of the position of every agent, easy Docker commands, environmental controls and a user friendly way to handle AIDO-submissions. An overview of the interface is shown in [](#fig:autolab_interface_overview).

<div figure-id="fig:autolab_interface_overview">
<img src="opmanual_autolab/images/autolab_interface/autolab_interface_overview.jpg" style="width: 100%"/>
<figcaption>
Framework of the Autolab Control System
</figcaption>
</div>

### Sections

* [](#autolab-server-setup): Installation and setup instructions for the Autolab server - TODO
* [](#autolab-interface-description): Description on how to use the Autolab control system - TODO
* [](#autolab-aido-operations): How to evaluate AIDO submissions inside the Autolab - TODO
* [](#autolab-complete-integration): The on-going efforts to integrate and automate the autolab. - TODO

### Overview

To run an Autolab, the so-called Autolab Constrol System is used. This is comprised of a Webserver running the _compose_ CMS, a _rosbridge_-server to communicate with ROS-Agents and a _Flask_-server to handle API calls. The framework and the different protocols used in the Autolab Control system are shown in [](#fig:autolab_control_structure).

<div figure-id="fig:autolab_control_structure">
<img src="opmanual_autolab/images/autolab_interface/Framework_autolab_new.png" style="width: 90%"/>
<figcaption>
Framework of the Autolab Control System
</figcaption>
</div>

