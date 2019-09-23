# Testing and debugging {#autocharging-debugging status=ready}

<div class='requirements' markdown="1">

Requires: put requirements here

Results: put result here

Next Steps: put next steps here
</div>


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

**Duckiebot does not stop while waiting in the queue in the charger**

Duckiebots are waiting in the queue with the help of vehicle detection and vehicle avoidance control nodes. You can solve this problem by increasing the desired_distance and minimal_distance parameters of vehicle avoidance control node. 

**Charging Manager was blinking with a frequency for charger 1 but the duckiebot did not drive in charger 1**

There can be several reasons for this occasion. Duckiebot could drive to the unintended direction if the intersection control node did not work correctly. You can find this out by looking at the logs of the Duckiebot. You may see logs as following 
```
driving to 0
```
This means that the Duckiebot wanted to go left. If the direction the duckiebot wanted to go and the direction it went agree, nothing from the intersection control was wrong. (If it is not the case, you can trim the parameters of unicorn_intersection_node.)

The second reason why this could happen is the LED detection. After arriving to the maintenance intersection, the Duckiebot waits for 15 seconds to detect the LED frequency of the traffic light. The image received by the camera is cut into three pieces. For traffic light detection, the upper part of the image is used. If the traffic light is not in this upper part of the image, the Duckiebot cannot detect the frequency of the LED. You can check this by looking at the led_detection_node/image_detection_TL topic:
First start the megacity container. After the container is ready type in the following commands: 

    laptop $ dts start_gui_tools HOSTNAME  
First publish the topic in order to let the duckiebot drive to the maintenance area    
    container $ rostopic pub -1 "/<robot_name>/maintenance_control_node/go_mt_charging" std_msgs/Bool true  
    container $ rqt_image_view  
Select the topic led_detection_node/image_detection_TL   

Now you are ready to debug the led detection process. The duckiebot will come to the maintenance intersection and the led detection node will be switched on. Then you will see a gray image. First check whether you see the LED on the image. If this is not the case, then either the placement of the traffic light was wrong or the Duckiebot arrived to the intersection not correctly. Then, check whether there is a blue circle around the LED. 



**Duckiebot drove in charger 1 but charging manager thought it went in charger 2**

Check whether the reference tags are placed correctly following the instructions for "setup of reference tags".




