# Run the demo


The megacity container has to be built and uploaded to the duckiebot as outlined in [here](https://docs.duckietown.org/DT17/)

**Step 1** Power on your bot and wait for the `duckiebot-interface` to initialize (the LEDs go off).

**Step 2**: Launch the demo by running:

if we run the container for the first we need to pull and run the container on the duckiebot

    laptop $ docker -H hostname.local run -it --net host --privileged -v /data:/data --name megacity duckietown/rpi-duckiebot-base:megacity /bin/bash

if the container is already on the duckiebot but has been stopped we can execute

    laptop $ docker -H ![hostname].local start megacity

Note: Many nodes need to be launched, so it will take quite some time.

**Step 3**: With the joystick or In a separate terminal, start the joystick GUI:

    laptop $ dts duckiebot keyboard_control ![hostname]

and use the instructions to toggle between autonomous navigation and joystick control modes.

**Step 4**: While in autonomous mode, publishing the following topic will direct the duckiebot to the maintenance area and start the entire charging procedure

    rostopic pub -1 "/<robot_name>/maintenance_control_node/go_mt_charging" std_msgs/Bool true

<div figure-id="fig:software_architec">
<img src="images/way_to_maintenance.png" style="width: 80%"/>
<figcaption>
Step 4
</figcaption>
</div>
<br />

**Step 5: Way to Maintenance** <br />Duckiebot calculates the shortest path to the maintenance entrance. During its journey it has the priority of way before other duckies. (indicated by purple blinking LEDs)

<div figure-id="fig:software_architec">
<img src="images/way_to_maintenance_2.png" style="width: 80%"/>
<figcaption>
Step 5
</figcaption>
</div>
<br />

**Step 6: Wait** <br />Duckiebot waits at the charging manager for 15 seconds to correctly read the light frequency from the trafficlight. the finite state machine transitions to wait state. When it is finished the finite state machine goes into the intersection coordination state.

<div figure-id="fig:software_architec">
<img src="images/wait.png" style="width: 80%"/>
<figcaption>
Step 6
</figcaption>
</div>
<br />

**Step 7: Way to Charging** <br />
The duckiebot has arrived at the maintenance entrance and receives further instructions from the trafficlight. Each frequency corresponds to one of the chargers

<div figure-id="fig:software_architec">
<img src="images/way_to_charging.png" style="width: 80%"/>
<figcaption>
Step 7
</figcaption>
</div>
<br />

**Step 8: Charging First in Line** <br />
At this given point of time the Duckiebot is the first one being able to leave the charger and it only needs to wait until it gets fully charged or someone triggers it to exit the charger and free another charging spot.

<div figure-id="fig:software_architec">
<img src="images/in charging.png" style="width: 80%"/>
<figcaption>
Step 8
</figcaption>
</div>
<br />

**Step 9: Way to City** <br />
The duckiebot is charged and enters the final state: Way to city. It follows the return path of the corresponding charger. By the time a Duckiebot receives a ready to go from a timer, the charge estimation algorithm or a human being two things happens: the finite state switches to LANE_FOLLOWING which makes the Duckiebot able to drive and the maintenance control node switches to WAY_TO_CITY. The Duckiebot is now guided out of the maintenance area. If the exit is reached, the maintenance control node is switched to NONE and the Duckiebot is again able to drive around in the city.

<div figure-id="fig:software_architec">
<img src="images/way_to_city.png" style="width: 80%"/>
<figcaption>
Graph of software architecture.
</figcaption>
</div>
<br />
