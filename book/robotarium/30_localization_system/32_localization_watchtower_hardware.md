# Watchtower Hardware Preparation {#localization-watchtower-hardware status=beta}

TODO : update


This document teaches you how to prepare a whole set of watchtower, which includes hardware preparation, hardware assembly, image preparation and setting up watchtowers in a city.

## Overview

This chapter will guild you what to prepare for building watchtowers and how to assemble them. Also, we'll talk about image preparation. Whenever the watchtowers and the images are prepared, we would give some advices for putting the watchtowers into the city.

## Before Assembly

### From Wooden Plates to Chasis Parts (Laser Cut):
The plates should be 4mm thick. To cut a set of traffic light, you need a plates with the size of roughly 347mm x 256mm x 4mm.


### Tubes Preparation:

We only need one tubes here. The spec of the tube is listed down here.

<col2 figure-id="tab:wt_escapes" figure-caption="Symbols to escape">
    <s>Length: </s> <s>572mm</s>
    <s>Diameter: </s> <s>20mm</s>
</col2>

We recommend you to buy a tube cutter. It'll save you from lots of troubles. After cutting the tube, you could polish the edges so that it won't heart you.

TODO: Add picture of tube

## Watchtower Assembly

TODO: These instructions are outdated.

### Wooden Box (with Raspberry Pi)
These are all the parts for assembly the wooden chasis.
<div figure-id="fig:wt_boxes_part" figure-caption="The parts for wooden box assemble.">
  <img src="watchtower/parts.jpg" style='width: 30em; height:auto'/>
</div>

##### Step 1: Stick the sliders
<div figure-id="fig:wt_step1" figure-caption="Step 1">
  <img src="watchtower/Step1.png" style='width: 25em; height:auto'/>
</div>

##### Step 2: Combine two walls of the box
<div figure-id="fig:wt_step2" figure-caption="Step 2">
  <img src="watchtower/Step2.png" style='width: 25em; height:auto'/>
</div>

##### Step 3: Stick the third wall of the box
<div figure-id="fig:wt_step3" figure-caption="Step 3">
  <img src="watchtower/Step3.jpg" style='width: 25em; height:auto'/>
</div>

##### Step 4: Stick the forth wall of the box
<div figure-id="fig:wt_step4" figure-caption="Step 4">
  <img src="watchtower/Step4.jpg" style='width: 25em; height:auto'/>
</div>

##### Step 5: Stick the stabler for the tube
Stick the small part, but DON'T stick the large plate. It should be the lid for the box that can be opened so that we could put Raspberry Pi in.
<div figure-id="fig:wt_step5" figure-caption="Step 5">
  <img src="watchtower/Step5.jpg" style='width: 25em; height:auto'/>
</div>

##### Step 6: Get the parts for camera mount
<div figure-id="fig:wt_step6" figure-caption="Step 6">
  <img src="watchtower/Step6.jpg" style='width: 25em; height:auto'/>
</div>

##### Step 7: Stick the stablers for tubes on camera mount
Note that there're two parts with larger holes and one part with a smaller hole. Tubes can go through lager hole but not smaller one. Thus, you should place the parts with smaller on the very top.
<div figure-id="fig:wt_step7" figure-caption="Step 7">
  <img src="watchtower/Step7.png" style='width: 25em; height:auto'/>
</div>

##### Step 8: Stick the other side of camera mount
<div figure-id="fig:wt_step8" figure-caption="Step 8">
  <img src="watchtower/Step8.png" style='width: 25em; height:auto'/>
</div>

##### Step 9: Stick the little T shape part on the lid of camera mount
You don't need to stick the lid on the camera.
<div figure-id="fig:wt_step9" figure-caption="Step 9">
  <img src="watchtower/Step9.jpg" style='width: 25em; height:auto'/>
</div>

##### Step 10: Parts you need for Raspberry PI holder.
Including the plate, two M2.5, 12mm Spacers, two M2.5, 6mm Screws, two M2.5, 4mm Screws and one Raspberry PI 3B+ Model.
<div figure-id="fig:wt_step10" figure-caption="Step 10">
  <img src="watchtower/Step10.jpg" style='width: 25em; height:auto'/>
</div>

##### Step 11: Install the spacers with the 6mm screws.
<div figure-id="fig:wt_step11" figure-caption="Step 11">
  <img src="watchtower/Step11.jpg" style='width: 25em; height:auto'/>
</div>

##### Step 12: Install the RPI with the 4mm screws.
<div figure-id="fig:wt_step12" figure-caption="Step 12">
  <img src="watchtower/Step12.jpg" style='width: 25em; height:auto'/>
</div>

After this step, we're finish with the chasis. Now let's assemble all the stuff.

##### Step 13: Put tubes through the chasis.

##### Step 14: Install camera mount on the very top of the tube.

##### Step 15: Insall the camera cables on Raspberry PI and let it goes through the tube.

##### Step 16: Install camera on the other side of the cable and put it on the camera mount.

##### Step 17: Done! Perfect!

TODO: Add picture of the rest steps.

## Image Setup

The image setup is the same procedure of preparing images for Duckiebots.

<!-- See [](#setup-duckiebot) -->

See setup-duckiebot

In the robotarium of ETH Zurich, the watchtowers has username **mom**, hostname **watchtowerXX** (where XX specify the number of the watchtower.) and password **MomWatches**.

However, it will be pretty time consuming to prepare the images one by one. Here we provide some little tricks to decrease time for manufacture.

### Image Prepare

#### Prepare one Duckibots Image

Prepare this Image until Step 8.11 but **DON’T** do ssh configuration. (You could do Step 8.14 if you wants Duckie Logos)

Name the watchtower `mom@watchtower01` with username `mom` and hostname `watchtower01`. Set the password to `MomWatches`.

<!-- See [](#setup-duckiebot) -->

See setup-duckiebot

If you wanna skip step 1~4 and save some time, you could simply download this image.

> [https://drive.google.com/file/d/1IU51wOO1IcZR5sYVOPMyMTqQ7pcLVOaU/view?usp=sharing](https://drive.google.com/file/d/1IU51wOO1IcZR5sYVOPMyMTqQ7pcLVOaU/view?usp=sharing)

We have prepare the image above for you. It has username `mom`, hostname `watchtower01` and password `MomWatches`. Also, it already upgrade to the version for Raspberry Pi3 B+.

Please note that in this image, since we will connect watchtowers to the network through ethernet cables, we deleted the Duckietown Wifi network file and it won't connect to duckietown network automatically so that it won't interfere the Ethernet network.

#### Prepare other 49 Images

There're two option for copying to 49 SD cards.

##### Option 1: Burn image to multiple SD cards at once

Save your first image from SD cards to laptop.
Plug in the SD card and umount it, you can see this chapter as reference.

<!-- See: [](#sdcards) -->

See sdcards

Then use this command to save image from the SD card.

    $ sudo dd bs=4M if=/dev/ of=~/watchtower.img status=progress

After this step, you will have your watchtower image in your laptop.

Then, put SD cards into USB adapters, insert as many SD cards as you can to your laptop. Burn the watchtower image to those image simultaneously.

<!-- See: [](#sdcards) -->

See sdcards

##### Option 2: Use SD card Duplicator

Buy a SD Card Duplicator, plug in source SD Card and target SD cards, click the start button, then you are done!

Although it's a pretty fast and convenient way, we found that a cheap duplicator could miss copying some library or system file due to its method of copying. Thus we recommend you buy a duplicator that do copy "bit by bit" (raw data copying) or choose option 2.

#### Change Configuration of each watchtower image

At this point you are almost done. Don't forget to change the configurations for each watchtower. Insert one SD card into Raspberry Pi, connect it with ethernet cable and do ssh.

    $ ssh mom@watchtower01.local

You are now ssh to the watchtower, we're setting up customize configuration for each watchtower.

First, change the hostname of the watchtower into `watchtowerXX`, where XX means the number for the watchtower. And restart your machine.

Afterwards, checkout 8.11 SSH configuration and set up the ssh configuration. You only need to do basic SSH config, create key pair.

<!-- See: [](#ssh) -->
See ssh

That's all! Redo the step for each SD card then you'll have all the SD cards ready.

## Setting Up Watchtowers in a City

There's only two general rule of putting watchtowers in a city. First, make sure that the field of views of watchtowers do cover the whole city. Second, there should be enough overlapping between field of view between watchtowers.

If you follow our design, the field of view is roughly in this size.

TODO: Add field of view picture

Currently at ETH, we set up the watchtowers like this.

TODO: Add picture

Beside the placement of watchtowers, they should be connected via ethernet cables. At ETH, the watchtowers are first connected to switches, then the switches are connected to a Wifi router.

TODO: Add some pictures

Last but nit least, these watchtowers needs _power_. Remember to prepare your USB chargers and cables that support 2.4A output.

TODO: Add picture
