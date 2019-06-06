# Localization System {#part:autolab-localization status=draft}

The auto-localization system is an important part of the Autolab, as it gives the localization of all Autobots in the city to a server. In the Autolab, the Autobots are Duckiebots that have been improved to Autolab specifications (see [](#autolab-autobot-specs)).

Note: Watchtowers are an experimental feature of Duckietown, which are currently only used in Autolabs.

___

**Sections**

* [](#localization-watchtower-hardware): How to assemble watchtowers.
* [](#localization-apriltags-specs): The april tag specifications and measure.
* [](#localization-offline): The manual to run localization offline.
* [](#localization-online): The manual to run localization online.
* [](#light-sensors): The manual to use the lights sensors of the watchtowers.
* [](#localization-software): An overview of the localization code.

___

**Overview**

The localization system has multiple purposes: 

* Automating completely the Autolab:
  * It allows the central system to discover if a Autobot runs out of the track
  * It allows more high level fleet control
* It allows the grading of the embodied challenges for the AIDO competitions

The localization system mainly relies on Apriltags, which are a kind of QR code. Each Autobot is provided with a plate with an Apriltag on top. By tracking the Apriltags on Autobots, the system evaluates their poses.

To track the Apriltags, we use watchtowers. In the spirit of Duckietown, a watchtower uses the same hardware as a Duckiebot and is integrated with the city. Thus, we developed a little tower which is about 60cm in height. At the top of the tower, the  pi-camera looks over a part of the city. We called it a "watchtower". The watchtowers are spread all over the city, and by combining the field of view of each tower, it is possible to cover the whole Autolab.

___

**The Basic Concept of the System**



___


**Hardware**

The hardware the system relies on are "watchtowers". A watchtower is a tower composed of Raspberry Pi 3 B+, and a pi camera on the very top of the tower (of course and other little components, we'll discuss that in the hardware chapter). The watchtowers are like surveillant cameras inside a Duckietown. With the camera on the top of the tower, we could see a field of town in view. Therefore, we could track an Autobot whenever it goes into the field of view of a watchtower.

The system are designed that watchtowers don't need to be in a specific height or pose as long as they could see a sufficient field of view and closed enough to track Apriltags in its field of view. However, we still provide the spec of the watchtowers so that one could produce watchtowers without testing field of view.

See hardware part in chapter [](#localization-watchtower-hardware)

TODO: Add hardware picture

___

**Software Setup**

he software part of the auto-localization is composed of two parts, localization pipeline and system calibration. The localization pipeline performs the localization of Autobots. Each watchtower will calculate the pose of an Autobot w.r.t a local reference tag and send it back to the server by a TCP/IP node. The server will then transfer the node into the frame w.r.t the origin tag.

The system calibration therefore became very important in this mean. Since the localization depends on local reference tags, the system needs to know the transformations between local tag frames and the origin tag frame. The function of system calibration is to provide these transformations. We'll discuss that in a later chapter.

See software part in chapter [](#auto-localization-software)

___

**Steps of Running Auto-Localization**

As we mention above, the server computer needs to have the transformation matrix to convert the pose from local-tag frame to a global-origin tag frame. Thus the system will first start with a calibration procedure.

After the calibration, the system could run happily!

See more about steps of running auto-localization system [](#auto-localization-operation-procedure)
