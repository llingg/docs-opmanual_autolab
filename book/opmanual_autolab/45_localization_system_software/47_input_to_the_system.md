
# Input to the system {#localization-input status=ready}

Excerpt: The input data fed to the localization system

<div class='requirements' markdown="1">

Requires: 

Results: 
</div>

<minitoc/>

## Autobot camera parameters

The Autobots already use a camera feed that is medium quality on the normal pipeline. All we do here is use the same image stream.
Todo: add actual quality 

## Watchtower camera parameters

For the Watchtowers it is a different story. As it is not used (yet) for anything else, we decided for the below reason to use a better image resolution and a higher shutter speed:

* The cameras are high, so the relative size of the Apriltags is small, so higher resolution mean better detection of the Apriltags (especially on the edges of the image)
* The Autobots are (mostly) always moving, and this created blur with the default shutter speed. With a higher shutter speed, we really decreased the blur, and the resulting loss of light is barely noticeable.

Todo: add images to see the difference

Todo: add actual numbers (resolution and shutter speed)

## Odometry

Todo : do
