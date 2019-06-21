# SOFTWARE - Localization software {#localization-software status=draft}

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

## Camera feed

### Autobot camera feed

The Autobots already use a camera feed that is medium quality on the normal pipeline. All we do here is use the same image stream.
Todo: add actual quality 

### Watchtower camera feed

For the Watchtowers it is a different story. As it is not used (yet) for anything else, we decided for the below reason to use a better image resolution and a higher shutter speed:

* The cameras are high, so the relative size of the Apriltags is small, so higher resolution mean better detection of the Apriltags (especially on the edges of the image)
* The Autobots are (mostly) always moving, and this created blur with the default shutter speed. With a higher shutter speed, we really decreased the blur, and the resulting loss of light is barely noticeable. 

Todo: add images to see the difference
Todo: add actual numbers (resolution and shutter speed)

## Apriltag detection



## Graph building and optimization

## Trajectory extraction


