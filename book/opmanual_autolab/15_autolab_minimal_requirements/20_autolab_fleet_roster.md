# Autolab fleet roster {#autolab-fleet-roster status=ready}

Excerpt: Handling the fleet of Autobots.

<div class='requirements' markdown="1">

Requires: Knowledge about what a Autolab is [](#part:autolab-definition)

Results: Knowledge about what a fleet roster is and why it is used

Next Steps: create your own autolab fleet roster and add data t it [](#autolab-autobot-hw-checks)
</div>

## Motivation

The goal of an Autolab is to have autonomous operation around the clock. Therefore, it is important that all agents (namely Autobots and Watchtowers) that are in the city are up to specification and in good shape. To keep track of all the changes and checks that a Autobot or Watchtower undergoes during its lifetime, some kind of information storage is needed.

## Implementation

To solve the above challenge, a so called `fleet roster` was created. It contains all the history of compliance and suitability tests that were done for agents in the Autolab. Every time a hardware check or calibration is done, this is noted in the fleet roster. So make sure that whenever you change anything related to your agents in your Autolab to put it here.
To make sure we can read out this data automatically and provide it to the operator of the  Autolab, the fleet roster needs to be well structured. When you create your own fleet roster for your Autolab, follow the structure below:

```
my-autolab-fleet-roster
  * autobots
    * autobotXX
      * camera-verification
        * YYYY-MM-DD-HH-MM-SS_camera_verification
          * calibrations
            * camera_extrinsic
              * autobotXX.yaml
            * camera_intrinsic
              * autobotXX.yaml
            * kinematics
              * autobotXX.yaml
          * (camera_test_report.yaml)
          * (config.yaml)
      * hardware-compliance
        * YYYY-MM-DD_hardware_compliance.yaml
      * (system-identification)
        * (YYYY-MM-DD-HH-MM-SS_system-identification)
          *...
  * watchtowers
    * watchtowerXX
      * intrinsic-calibration
        * watchtowerXX.yaml
```

Note: `The camera_intrinsic.yaml`, `camera_extrinsic.yaml` and `kinematics.yaml` are created when you calibrate your Autobot using the calibration procedures described in [](+opmanual_duckiebot#camera-calib ) and [](+opmanual_duckiebot#wheel-calibration).The `YYYY-MM-DD_hardware_compliance.yaml` file is created using one of our helper scripts. The procedure to follow can be found [here](#autolab-autobot-hw-checks).

## Creating your own fleet-roaster

You can create your own `fleet roster` repository on GitHub using the structure shown above. If you know how to create a new repository you can proceed right away. If not, read the instructions [here](https://help.github.com/en/enterprise/2.13/user/articles/creating-a-new-repository) to find out how you can create a new repository on GitHub.

Make the name of your `fleet roster` explicit, like for instance `YOURINSITUTION_fleet_roster`, and remember this name as it will be asked later by the Autolab control interface.
