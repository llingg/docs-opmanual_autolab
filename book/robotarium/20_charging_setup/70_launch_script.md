# DEMO - Launch your script {#autocharging-launch status=beta}

<div class='requirements' markdown="1">

Requires: put requirements here

Results: put result here

Next Steps: put next steps here
</div>


As soon as you have created your own configuration file described above, you are ready to test your setup.

Launch the final script inside the root folder of Duckietown

    make megacity-<city_name>

This will take some time. If everything launches, you are ready to go!

## Prepare and launch the TCP server

Duckiebots need to know which charger has how many free spots left. This is done via the TCP Communication package.

### Chose a machine

Decide which machine will be running 24/7, acting as TCP server.

### Get the files on that machine

    git checkout megacity
    git pull

### Prepare the network

Chose a fixed IPv4 address for the server and add an IP reservation to your router.

### Adjust the parameters

Go to

    catkin_ws/src/00-infrastructure/duckietown/config/baseline
    /tcp_communication/tcp_communication_server_node/default.yaml

and adjust the charging_stations parameters. Note that the name (i.e. stationX) need to match with the names in the Maintenance Control Node.

Adjust the IP and PORT if needed. If you change these settings, you need to adjust

    catkin_ws/src/00-infrastructure/duckietown/config/baseline
    /tcp_communication/tcp_communication_client_node/default.yaml

as well.

### Launch the TCP server {#autocharging-tcp-server}

Enter the command

    make tcp-server
