# SOFTWARE - Localization software {#localization-software status=ready}

<div class='requirements' markdown="1">

Requires: The code for localization (in [dt-env-developer](#dt-env-developer))

Results: Better knowledge of the working of the current localization pipeline

Next Steps: Contribute to make it better 
</div>

## Goals and specifications of the localization system

For all Autobots in the Autolab:

* 10 Hz rate pose trajectory (position and orientation)
* 1 cm accuracy
* 5 degree accuracy (less important maybe)

## Outline of the code structure

Note: In all the following, an agent will refer indifferently to a Watchtower or an Autobot.

The pipeline is roughly the following:

* Every agent has a camera flow of image that is either recorded to be used later or directly sent to a processor
* The processor (can be the agent itself or a central powerful computer) takes each image and extract, for each found Apriltag, the relative pose between the camera frame and the Apriltag frame, with the Apriltag ID and the time stamp of the image. This result is a stamped Apriltag transform.
* This set of transforms is sent to a graph builder, that uses all those to create a big graph in G2O, a graph optimization library.
* The graph builder does a lot of work (described below) to recreate and synchronize the time dependency of a moving Autobot (which, contrary to Watchtowers, cannot be represented as one vertex in the graph, but rather as successive vertices with unique time stamps).
* The graph is regularly optimized, and the trajectory of each Autobot is extracted.

The global frame is fixed thanks to the measured ground Apriltags, that are fed into the graph at initialization, and set as fixed points of the graph.

## Camera parameters

### Autobot camera parameters

The Autobots already use a camera feed that is medium quality on the normal pipeline. All we do here is use the same image stream.
Todo: add actual quality 

### Watchtower camera parameters

For the Watchtowers it is a different story. As it is not used (yet) for anything else, we decided for the below reason to use a better image resolution and a higher shutter speed:

* The cameras are high, so the relative size of the Apriltags is small, so higher resolution mean better detection of the Apriltags (especially on the edges of the image)
* The Autobots are (mostly) always moving, and this created blur with the default shutter speed. With a higher shutter speed, we really decreased the blur, and the resulting loss of light is barely noticeable. 

Todo: add images to see the difference

Todo: add actual numbers (resolution and shutter speed)


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

### Apriltag extraction

No matter how (or on which device) we get the image, we need to process it to get two things for each Apriltag in the image:

* its relative pose
* its unique Id

Todo: explain process and code, link repos etc...

## Graph building and optimization

## Trajectory extraction


