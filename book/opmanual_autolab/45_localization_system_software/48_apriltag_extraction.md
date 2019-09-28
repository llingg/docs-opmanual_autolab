# Apriltag detection and extraction  {#localization-apriltag-extracion status=ready}

Excerpt: The pipeline to retrieve data from apriltags in images.

<div class='requirements' markdown="1">

Requires: 

Results: 
</div>

<minitoc/>

## Apriltag detection

From here, there are many different ways of doing things. The Apriltag detection is very computationally expensive, and different strategies can be used:

* Offline acquisition : each agent just records the images, then they are gathered and processed later, offline, without any time requirement. This is the easy, but unsatisfactory way. This also means that the localization can only be used *a posteriori*, so it can not be used for real time decision making.
* Online acquisition : the images are processed during the experiment, and the graph and localization is done (with some delay) online. This is much harder to do as processing images is costly. Two strategies can be used here:
    * Each agent tries to do the processing directly onboard and just sends the transforms to a central ROS master that will do the graph
    * Each agent directly sends the images and the central ROS master does the processing for every agent (implies having a good computer)
    * A mix of the two is also possible (the Autobot send the images, the watchtowers process them for instance)


### Offline acquisition of images

As explained in [](#localization-demo), the offline localization just needs every agent to record in rosbags the image stream. Then, it is download and feed to a Apriltag extractor node, that outputs all the transforms to a new bag, that is then fed to the graph optimizer. 

### Online acquisition of images

To do online, there is a whole new thing to worry about: How to communicate between different ROS masters.

Remember, each agent has its own ROS master, and they cannot communicate with each other natively, even though they are on the same network.

The currently used solution is to:

* Create a new central ROS master
* On each agent, create a "bridge" node that communicates with the agent's ROS master and the central ROS master
* Through this bridge node, get all the images from the agents to the centra ROS master

Todo: Actually explain how we do that.

## Apriltag extraction

No matter how (or on which device) we get the image, we need to process it to get two things for each Apriltag in the image:

* its relative pose
* its unique Id

Todo: explain what a transform is
Todo: explain process and code, link repos etc...