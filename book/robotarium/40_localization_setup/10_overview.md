# Overview {#autolocalization-overviews status=beta}

The auto-localization system is an important part of AI-DO competition. Since we need to score each team with the performances of their cars, it's necessary to have a system to localize and track the movement of these Duckiebots.

## Overview

The whole purpose of the auto-localization is to localize all Duckiebots in a Duckietown. By this, we could track them and score them in the AI-DO competition.

The concept behind the auto-localization is by using the detections of Apriltags. Each Duckiebots is provided with a plates with an Apriltag. Thus, by tracking the Apriltags on Duckiebots, we could calculate their poses.

Moreover, Since it's Duckie"town". We mean to build our camera system that integrate with the city but not a overhead camera which basically have nothing to do with the infrastructure. Thus, we develop a little tower which is about 60cm in height. At the top of the tower, there's a camera which looks over a part of the city. We called it a "watchtower". The watchtowers are spreaded all over the city, and combine with the field of views of each tower, it is possible to surveillant the whole area.

## The Basic Concept of the System

Thanks to the famous Apriltags Library, it's not only easy to get the 3D pose (position and orientation), but also robust enough to rely on these small tags. As long as a system could "sees" the tags, we could know the exact poses of them.

The watchtower first sees tags which are on the robots and on the side of the roads (may be traffic sign or tags which put there intentionally). The raspberry pi inside the watchtower will then convert the pose of robot from the frame of camera to the frame of these side tags, which we called them "reference tags". And sent the pose to the server computer.

Last, since the server computer contains a data base that contains the transformations matrix from reference tags frames to the origin frame, it could easily convert the pose from local references to the global origin point.

<figure>
    <p align="center">
      <img style="width:40em" src="images/concept.png"/>
    </p>
</figure>

## Hardware

The hardware the system relies on are "wathctowers". A watchtower is a tower composed of Raspberry Pi 3 B+, and a pi camera on the very top of the tower. The watchtowers are like surveillant cameras inside a Duckietown. With the camera on the top of the tower, we could see a part of town in view. Therefore, we could track a Duckiebot whenever it goes into the field of view of a watchtower.

The system are designed that watchtowers don't need to be in a specific height or pose as long as they could see a sufficient field of view and closed enough to track Apriltags in its field of view. However, we still provide the spec of the watchtowers so that one could produce watchtowers without testing field of view.

See hardware part in chapter [](#autolocalization-hardware)

<figure>
    <p align="center">
      <img style="width:10em" src="images/watchtower.png"/>
    </p>
</figure>

## Software Setup

The software part of the auto-localization is composed of two parts, localization pipeline and system calibration. The localization pipeline performs the localization of Duckibots. Each watchtower will calculate the pose of an Duckiebot w.r.t a local reference tag and send it back to the server by a TCP/IP node. The server will then transfer the node into the frame w.r.t the origin tag.

The system calibration therefore became very important in this mean. Since the localization depends on local reference tags, the system needs to know the transformations between local tag frames and the origin tag frame. The function of system calibration is to provide these transformations. We'll discuss that in a later chapter.

See software part in chapter [](#autolocalization-software)

## Steps of Running Auto-Localization

As we mention above, the server computer needs to have the transformation matrix to convert the pose from local-tag frame to a global-origin tag frame. Thus the system will first start with a calibration procedure.

After the calibration, the system could run happily!

See more about steps of running auto-localization system [](#autolocalization-system_launch)
