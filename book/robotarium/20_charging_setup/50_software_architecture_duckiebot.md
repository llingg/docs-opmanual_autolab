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
