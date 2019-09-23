# Run the demo {#run-demo status=ready}


The megacity container has to be built and uploaded to the duckiebot as outlined in [here](https://docs.duckietown.org/DT17/)

**Step 1** Power on your bot and wait for the `duckiebot-interface` to initialize (the LEDs go off).

**Step 2**: Launch the demo by running:

if we run the container for the first we need to pull and run the container on the duckiebot

    laptop $ docker -H hostname.local run -it --net host --privileged -v /data:/data --name megacity duckietown/rpi-duckiebot-base:megacity /bin/bash

if the container is already on the duckiebot but has been stopped we can execute

    laptop $ docker -H ![hostname].local start megacity

Note: Many nodes need to be launched, so it will take quite some time.
