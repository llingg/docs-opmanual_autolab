# Software architecture {#autocharging-software-architecture status=beta}

Operating a Duckiebot inside a megacity requires software which can switch from state to state. In this section, we describe how we have fit the maintenance code into the bigger picture.

## Overview

The software responsible for the autocharging capability is running entirely in the following two nodes:

1. Maintenance control node
2. Charging control node

## Maintenance control node

The maintenance control main goal is to transition through the maintenance states that run parallel to the FSM states in order to execute the autocharging procedure. The maintenance states and their transitions are explained in the run_demo part. Each time a FSM state transition occurs the following log info is printed in the megacity container:


    rospy.loginfo("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
    rospy.loginfo("Maintenance Control Node MT State: " + str(state))
    rospy.loginfo("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")

If you would like to test a specific maintenance state (i.e. for testing a specific path like path_calib), change the state with

    rostopic pub -1 "/<robot_name>/maintenance_control_node/set_state" std_msgs/String "<state_name>"

There exist the following maintenance states: [WAY_TO_MAINTENANCE, WAY_TO_CHARGING, CHARGING, WAY_TO_CITY]

## Charging control node

The charging control node is responsible for the duckiebots action when it arrived in the charging area.
For example when the duckiebot is under the rails but there is no contact a callback functions triggers a wiggle in order to establish charging contact.
Further is checks necessary condition for the duckiebot to leave the charger.



Operating a Duckiebot inside a megacity requires software which can switch from state to state. In this section, we describe how we have fit the maintenance code into the bigger picture.

## Transition of states

Below you may find a descriptive explanation on the transition of states on Duckiebot for autocharging.

As soon as the megacity container is started, a Duckiebot is placed into the city and is able to drive around. A timer, the charge estimation algorithm or a human being triggers a topic called GO_TO_CHARGING from the maintenance control node in order to recognize the time when we need to put the Duckiebot into the charging area. When this state is switched from NONE to WAY_TO_MAINTENANCE, the Duckiebot is guided towards the entrance of the maintenance area by a fleet management algorithm(The responsible node for this algorithm is the action_dispatcher_node). Having arrived at the entrance, this state will get switched to WAY_TO_CHARGING. On the maintenance intersection, the Duckiebot will recognize the maintenance apriltag and its FSM State will transit from INTERSECTION_COORDINATION to WAIT. There it will wait for 15 seconds and take multiple measurements for the frequency of charging manager's blinking LED light. The detected frequency will be determined according to the most measured frequency. Since every frequency corresponds to a charger index, the charger which Duckiebot should go will be set. For every charger there is a predefined route, hence,, the Duckiebot will take the turns to reach the charger according to the predefined route. After entering the charger, a transition of state from WAY_TO_CHARGING to CHARGING follows and the finite state machine state switches to IN_CHARGING_AREA. These states mean that the Duckiebot is inside the charger and that it will keep distance from other Duckiebots queued up there. As soon as the Duckiebot sees a red line and a stop tag at the end of a charger the finite state is switched to CHARGING_FIRST_IN_LINE. At this given point of time the Duckiebot is the first one being able to leave the charger and it only needs to wait until it gets fully charged or someone triggers it to exit the charger and free another charging spot. 15 seconds before requesting to leave the charger, Duckiebot's lights on the backbumper will turn blue. In order to leave the charger, the Duckiebot needs to be charged for a certain amount of time and it should not detect another Duckiebot in front of it. While leaving the charger the finite state switches to LANE_FOLLOWING which makes the Duckiebot able to drive and the maintenance control node switches to WAY_TO_CITY. The Duckiebot is now guided out of the maintenance area. If the exit is reached, the maintenance control node is switched to NONE and the Duckiebot is again able to drive around in the city.

