# Autobot hardware compliance checks {#autolab-autobot-hw-checks status=ready}

Excerpt: run a compliance test and store the information at the right place

We have put together a step-by-step instruction to ensure that every Autobot that enters the Autolab is ready to go. We keep track of them in a GitHub Repository which will be used to keep track of the change history of every Autobot as well as to provide additional information to the user.

<div class='requirements' markdown="1">

Requires: a assembled [Autobot](#autolab-autobot-specs)

Results: a Autobot which is ready to be used in the Autolab.

</div>

## Checklist

### Step 0

Power on the Duckiebot. Then run the following command on your Computer. It will launch a Docker container on your Duckiebot which creates the suitability test report:

    laptop $ docker -H HOSTNAME.local run -it --network host -v /data:/data -v /sys/firmware/devicetree:/devfs:ro duckietown/duckiebot_hw_checks:daffy

### Step 1

If you mounted the Raspberry Pi on top, check that a pin protector is mounted on the pins of the hut to prevent pins from shorting out.
If no protector is installed yet, then first check that no pins are bent or are making contact and then add the protector. It should slide into place without applying any force. The stl file to 3D print the pin protector can be found in [](#adding-hw-to-bot).


### Step 3

Check if the standoff on the Duckiebot is mounted and an April tag matching the Duckiebot name (hostname) is attached. The April tag needs to be aligned with the front of the top plate and centered. On the top plate you will find engraved lines that show you where to position it.  the standoff needs to be mounted in the very front of the bot. A picture can be found in [](#fig:standoffs-mounted-autobot)

### Step 4

Check if a rubber duckie sits on the bot. If not, put one on it now.
As the rubber duckies are rather bad at balancing and lack hands to hold on to the Duckiebot, use double sided tape to fix it to the Duckiebot.

### Step 5

Make sure the back bumper is properly fastened to the Duckiebot (no wiggling allowed).

### Step 6

Check that no cables can interfere with the wheels of the Duckiebot. If necessary, use zip-ties to fix everything properly.

### Step 7

Check that all cables are properly attached. Especially check that the camera cable is plugged in correctly and locked.

### Step 8

If all above steps are done, press <kbd>y</kbd> and <kbd>ENTER</kbd> on your keyboard

### Step 9

In ETH, we currently use batteries that are no longer produced. To replace them, we manufacture special batteries just for Duckietown which you will have gotten with your Duckiebot. So if you use these that's even better. To be able to write down what battery you use, press <kbd>n</kbd> and <kbd>ENTER</kbd>. This will give you the possibility to type in what battery you use.

### Step 10

Check that a standard actuators (yellow motors) are used to drive the Duckiebot. If that is the case, press  <kbd>y</kbd> and <kbd>ENTER</kbd> on your keyboard, otherwise press <kbd>n</kbd> and <kbd>ENTER</kbd>. Afterwards describe the other motors the Duckiebot is using.

### Step 11

Fill in your name and press <kbd>ENTER</kbd>, the container should now close without errors.

### Step 12
The freshly created suitability test report can be found under ```http://HOSTNAME.local:8082/config/YYYY-MM-DD_hardware-compliance.yaml```

### Step 13

Now upload the file that was created to your `fleet roster`. If you don't know what a `fleet roster` is and how to create one, read [this](#autolab-fleet-roster). Once you created your own `fleet roster`, upload your newly created file to it.

if you know how to do upload the files to GitHub, you can skip the next section. If not, we will give you a step by step instruction in the following:

Clone your fleet-roster repository onto your local computer.
To do this, open a terminal and type

    laptop $ git clone git@github.com:YOUR-WORKSPACE/YOUR-FLEET-ROSTER.git

create the directory where you want to place the file with the following code. you need to exchange `XX` by the number of the actual autobot and fill in the current date.

    laptop $ mkdir YOUR-FLEET-ROSTER/autobots/autobotXX/hardware-compliance/YYYY-MM-DD_hardware-compliance

add the new file into the above mentioned folder. The easiest way to do this is just copying the file and placing it in the folder mentioned in step 2 using the file explorer.

now you are set to push things to github. Run the following in the same terminal as above: (again replace XX by the number of the autobot)


    laptop $ cd YOUR-FLEET-ROSTER
    laptop $ git add .
    laptop $ git commit -m "hardware compliance test for autobotXX"
    laptop $ git push origin aido2  


### Step 13

Verify that everythig worked out by checking the yaml file in `YOUR-FLEET-ROSTER/autobots/autobotXX/hardware-compliance/YYYY-MM-DD_hardware-compliance/YYYY-MM-DD_hardware-compliance.yaml`.
It should look as follows:

    verdict: pass
    hostname: autobot01
    date: 2019-04-01
    mac-adress: B8:27:EB:9B:BD:DD
    platform: Raspberry Pi 3B+
    hat_version: 2018D v1.1
    usb-memory: class 10 micro SD
    sd-memory: class 10 micro SD
    battery: RAVPOWER RP-PB07
    actuation: DG01D dual-axis drive gear (48:1)
    tester_name: Gyro Gearloose
