# Hardware and Image {#autolocalization-hardware status=beta}

This document teaches you how to prepare a whole set of watchtower, which includes, hardware assembly, image preparation and setting up watchtowers in a city.

## Overview

This chapter will guild you what to prepare for building watchtowers and how to assemble them. Also, we'll talk about image preparation. Whenever the watchtowers and the images are prepared, we would give some advices for putting the watchtowers into the city.

## Hardware Assembly

A watchtower is basically the half side of a traffic light which includes a camera.

See [](#components_assembly)

## Image Setup

The image setup is the same procedure of preparing images for Duckiebots.

In the robotarium of ETH Zurich, the watchtowers has username `mom`, hostname `watchtowerXX` (where XX specify the number of the watchtower.) and password `MomWatches`.

However, it will be pretty time consuming to prepare the images one by one. Here we provide some little tricks to decrease time for manufacture.

### Image Prepare

#### Prepare one Duckibots Image

Prepare this Image, but _DON’T_ do ssh configuration. (You could do Step 8.14 if you wants Duckie Logos)

Name the watchtower `mom@watchtower01` with username `mom` and hostname `watchtower01`. Set the password to `MomWatches`.

We recommend you to erase the Wifi configuration file in /etc/Network/system-connections/duckietown. Since we are connecting watchtowers through Ethernet, it will confuse your Wifi router if it connects to the router via Ethernet and Wifi at the same time.

#### Prepare other 49 Images

There're two option for copying to 49 SD cards.

##### Option 1: Burn image to multiple SD cards at once

Save your first image from SD cards to laptop.
Plug in the SD card and umount it, you can see this chapter as reference.

See: [](#sdcards)

Then use this command to save image from the SD card.

    $ sudo dd bs=4M if=/dev/ of=~/watchtower.img status=progress

After this step, you will have your watchtower image in your laptop.

Then, put SD cards into USB adapters, insert as many SD cards as you can to your laptop. Burn the watchtower image to those image simultaneously.

See: [](#sdcards)

##### Option 2: Use SD card Duplicator

Buy a SD Card Duplicator, plug in source SD Card and target SD cards, click the start button, then you are done!

Although it's a pretty fast and convenient way, we found that a cheap duplicator could miss copying some library or system file due to its method of copying. Thus we recommend you buy a duplicator that do copy "bit by bit" (raw data copying) or choose option 2.

#### Change Configuration of each watchtower image

At this point you are almost done. Don't forget to change the configurations for each watchtower. Insert one SD card into Raspberry Pi, connect it with ethernet cable and do ssh.

    $ ssh mom@watchtower01.local

You are now ssh to the watchtower, we're setting up customize configuration for each watchtower.

First, change the hostname of the watchtower into `watchtowerXX`, where XX means the number for the watchtower. And restart your machine.

Afterwards, checkout 8.11 SSH configuration and set up the ssh configuration. You only need to do basic SSH config, create key pair.

See: [](#ssh)

That's all! Redo the step for each SD card then you'll have all the SD cards ready.

## Setting Up Watchtowers in a City

There's only two general rule of putting watchtowers in a city. First, make sure that the field of views of watchtowers do cover the whole city. Second, there should be enough overlapping between field of view between watchtowers.

Currently at ETH, we set up the watchtowers like this.

<figure>
    <p align="center">
      <img style="width:25em" src="images/placement.png"/>
    </p>
</figure>

The transparent blue is the estimates field of view of a watchtower.

Beside the placement of watchtowers, they should be connected via ethernet cables. At ETH, the watchtowers are first connected to switches, then the switches are connected to a Wifi router.

Last but not least, these watchtowers needs _power_. Remember to prepare your USB chargers and cables that support 2.4A output.
