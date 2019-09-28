# BUILDING - Apriltags specifications {#localization-apriltags-specs status=ready}

Excerpt:  The AprilTag specifications and measure.

<div class='requirements' markdown="1">

Requires: A fully operational [Duckietown](+opmanual_duckietown#duckietowns), compliant [autobots](#autolab-autobot-specs) and a [map of the Autolab](#autolab-map-making).

Results: The city is ready to be used for localization

Next Steps: The two localization demos: [offline and online](#localization-demo)
</div>

<minitoc/>


## Why do we need ground Apritags

Because of localization.

## Making the ground Apriltags {#making-ground-apriltags}

As a reminder, the Apriltags already have predetermined sets of usecase. The ranges of tags are specified in [](#tab:tag-ranges).

For localization, **the ground Apriltags are in range 300 to 399**.

<col4 figure-id="tab:tag-ranges" figure-caption="Apriltag ID ranges">
    <span>Purpose</span><span>Size</span><span>Family</span><span>ID Range</span>
    <span>Traffic signs</span><span>6.5cm x 6.5cm</span><span>36h11</span><span>1-199</span>
    <span>Traffic lights</span><span>6.5cm x 6.5cm</span><span>36h11</span><span>200-299</span>
    <span>Localization</span><span>6.5cm x 6.5cm</span><span>36h11</span><span>300-399</span>
    <span>Street Name Signs</span><span>6.5cm x 6.5cm</span><span>36h11</span><span>400-587</span>
</col4>

To print the ones you need, you can find them here: [pdf](https://github.com/duckietown/Software/blob/master18/catkin_ws/src/20-indefinite-navigation/apriltags_ros/signs_and_tags/tag36h11.pdf) [ps](https://github.com/duckietown/Software/blob/master18/catkin_ws/src/20-indefinite-navigation/apriltags_ros/signs_and_tags/tag36h11.ps)

## Placing the ground Apriltags and the Watchtowers

Description to come.

## Generating the map in duckietown-world

You should already have a map as explained in [](#autolab-map-making). If not, go back and do it, as it will be necessary for the rest.

## Adding the ground Apriltags localization to your map

### Before measuring

This is the important part of the Apriltag specifications. You need to make sure that:

* The ground Apriltags are indeed 6.5cm x 6.5cm. If they are not, the localization system will get flawed data and thus will be useless.
* The ground Apriltags are very well fixed to the ground (using tape and nails). Once they are measured they should not move at all.
* The ground Apriltags are in angle 0° modulo 45°. This will make the following much easier.


### Measuring

* The measure of the ground Apriltags needs to be very precise. You should have a meter with millimeter precision. 
* In the map you created before, the origin is the bottom left corner. Remember this as it is important.
* The tiles have an internal and an external border, because of the interlocking slots. In the following, as for the map, take the inside bottom left as reference for a tile.
* Each apriltag placement will be measured relatively to the tile it is on, from the above described origin.
* Always measure the center of the April tag itself.

**How to measure**:

In the following, you will be asked 5 numbers for each Apriltag:

* the x coordinate of the tile : it is the number (starting at 0 at the first bottom left origin tile) of tile along the x axis (bottom axis)
* the y coordinate of the tile : same as for x, it starts at 0
* the x measure of the Apriltag on the tile : you can get it by blocking your meter in the interior left edge and measuring (in meters) the distance from the interior edge to the center of the Apriltag.
* the y measure of the Apriltag on the tile : you can get it by blocking your meter in the interior bottom edge and measuring (in meters) the distance from the interior edge to the center of the Apriltag.
* the orientation of the apriltag (in degrees) : it is 0 if the Apriltag's name is alined normaly with the x axis (eg readable from the "bottom" of the map). Then it is defined with the trigonometric convention (counter-clockwise). This should normally always be in multiples of 45°

TODO : add a picture to make that clear.

### Filling the map in

Once you are sure of your positioning of the Apriltags, you can start measuring them. To do so:

* Open a terminal inside the duckietown-world repository, as you did to create your map. Your map should still be in the `src/duckietown_world/data/gd1/maps` folder.

Run the following command:

    laptop $ python3 src/apriltag_measure/measure_ground_apriltags.py ![MAP_NAME]

* Follow the instructions in the terminal : choose an Apriltag number, and fill in the 5 asked numbers, as described above.
* If an Apriltag was already filled in before (if you are changing your map for instance), you will be asked to confirm the overwritting of the positionning. As everything is versionned in github, you can always go back to find the previous positions if need be.
* If you try recording an Apriltag number than is not in the allocated range (300-399), the script will also ask to confirm.
* At the end, just confirm the saving. The resulting map will be where it was before, with now the Apriltag measures added to it.
* As described in [](#autolab-map-making), you should recompile your map and visualize the apriltags on it (easy debug to find obvious mistakes).
