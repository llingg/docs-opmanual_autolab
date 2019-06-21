# Setup {#traffic_light_setup status=beta}

## Hardware setup

Traffic lights are connected to a watchtower raspberry. In Zurich for instance, those are currently watchtowers 4, 9, 12 and 15.

## Software setup

The raspberry need to have DB18 setup with docker. Refer to **To be determined** for watchtower setup

Then, once the watchtower is up and running, run :

    docker -H watchtowerXX.local run -dit --privileged --name trafficlight --network=host duckietown/traffic_lights

The lights should start blinking now.
