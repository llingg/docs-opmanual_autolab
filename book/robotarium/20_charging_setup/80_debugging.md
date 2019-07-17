# Testing and debugging {#autocharging-debugging status=beta}

## Debug the whole charging pipeline

If megacity is launched, a Duckiebot will drive for X minutes and then go to the charging station. After Y minutes, it will leave it again. X and Y are defined in the yaml file for the Charging Control Node. If you would like to test the whole charging procedure, place your Duckiebot on a road which ends in the intersection which is connected to the maintenance area. Then, request the Duckiebot to go charging:

    rostopic pub -1 "/<robot_name>/maintenance_control_node/go_mt_charging" std_msgs/Bool true

The Charging Control Node will as the TCP server for a free charging spot and if available reserve it.

Now, let your Duckiebot drive autonomously (L1 on your Joystick or 'a' on your virtual joystick).

## Debug a single maintenance state

There exist the following maintenance states: [WAY_TO_MAINTENANCE, WAY_TO_CHARGING, CHARGING, WAY_TO_CALIBRATING, CALIBRATING, WAY_TO_CITY]

If you would like to test a specific maintenance state (i.e. for testing a specific path like path_calib), change the state with

    rostopic pub -1 "/<robot_name>/maintenance_control_node/set_state" std_msgs/String "<state_name>"

## Troubleshooting

**A Duckiebot gets stuck while traversing through a charger**

This happens if the friction of the current collector is too high. Try to bend the 3D printed part a little down (multiple times) until the force acting on the charging rails is lower. You could also reprint the current collector with thinner connections (use the Customizer on Thingiverse). Also, ensure that the tiles of the charger are flat.

**Duckiebot turns off as soon as rails are touched**

Depending on the battery, if no voltage lies across the charging rails, the Raspberry Pi may reboot. This is a known issue and may be solved by adding capacitors to the add-on board - this is in work by Autolab Zurich.

**Duckiebot does not charge**

There exist multiple reasons for that: did you turn on the power supply? However, most of the times the current collector / the rails are dirty. Clean them with alcohol or sanding paper.

<!--TODO: troubleshooting,explanations  -->
**Duckiebot does not stop while waiting in the queue in the charger**


**Charging Manager was blinking with a frequency for charger 1 but the duckiebot did not drive in charger 1**

**Duckiebot drove in charger 1 but charging manager thought it went in charger 2**




