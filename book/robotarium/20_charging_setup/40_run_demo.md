# Run the demo

## Preparation

The megacity container has to be built and uploaded to the duckiebot as outlined in [here](https://docs.duckietown.org/DT17/)

**Step 1** Power on your bot and wait for the `duckiebot-interface` to initialize (the LEDs go off).

**Step 2**: Launch the demo by running:

    laptop $ docker -H ![hostname].local start megacity

Note: Many nodes need to be launched, so it will take quite some time.

**Step 3**: With the joystick or In a separate terminal, start the joystick GUI:

    laptop $ dts duckiebot keyboard_control ![hostname]

and use the instructions to toggle between autonomous navigation and joystick control modes.

**Step 4**: While in autonomous mode, publishing the following topic will direct the duckiebot to the maintenance area and start the entire charging procedure

    rostopic pub -1 "/<robot_name>/maintenance_control_node/go_mt_charging" std_msgs/Bool true


**Step 5**: Way to Maintenance: Duckiebot calculates the shortest path to themaintenance entrance. During its journey ithas the priority of way before other duckies. (indicated by purple blinking LEDs)


**Step 6**: Wait: Duckiebot waits at the charging manager for 10 seconds to correctly read the light frequency from the trafficlight.


**Step 7**: Way to Charging: The duckiebot has arrived at the maintenanceentrance and receives further instructionsfrom the trafficlight. Each frequencycorresponds to one of the chargers 


**Step 8**: Way to City: The duckiebot is charged and enters the finalstate: Way to city. It follows the return pathof the corresponding charger.

