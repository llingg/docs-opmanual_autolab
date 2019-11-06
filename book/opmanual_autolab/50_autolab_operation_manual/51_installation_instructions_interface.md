# SOFTWARE - Setting up the Autolab server {#autolab-server-setup status=ready}

<div class='requirements' markdown="1">

Requires: Server for hosting the managment interface, pre-installed with Ubuntu 18.04 LTS

Results: Setup server to run the Autolab control system

</div>

This Unit describes the different steps needed to setup an Autolab Server. 

### Installing compose

Follow [these instructions](http://compose.afdaniele.com/docs/devel/setup-docker) to install compose on your server. 

### Installing the necessary packages

After installing compose, open your **Firefox** browser (other browsers are **not** supported) and navigate to the url forwarding to the port 80 of the Autolab Server. Most likely, when inside a local network, `server-hostname`.local will work. After logging in, navigate to the `Package Store` tab to and install the **Lab Controls** package ([](#fig:lab_controls_pkg)) as well as the **ROS** package.

<div figure-id="fig:lab_controls_pkg">
<img src="opmanual_autolab/images/autolab_interface/lab_controls_package.png" style="width: 90%"/>
<figcaption>
Installed Lab controls package
</figcaption>
</div>

### Running the Flask server

The Flask Server handles every API call from and to the Autolab interface. To run it, first the following repository needs to be cloned:

    $ git clone git@github.com:duckietown/autolab_control_flask_scripts.git

The next step involves setup for passwordless ssh, Watchtowers with a hostname `watchtowerXX.local` where XX is between 01 and 60 as well as Duckiebots with `autobotXX.local` where XX is between 01 and 20 will be setup. simply run the following script:

    $ ./setup_ssh.sh

The Flask server has a defined list of agents which are able to run in the lab: `device-list.txt`. Adapt this list to reflect your agents, but remember that they need to follow this naming convention: `watchtowerXX.local` or `autobotXX.local`.

Finally, the Flask server can be started via:

    $ python flask_server.py

### Installing the Rosbridge server

The Rosbridge server is used for communication between the Autolab interface and every ROS Agent in the lab running the acquisition-bridge (more on this in [](#localization-software)). To install it first clone the following repository:

    $ git clone git@github.com:duckietown/rosbridge_kinetic.git

Inside the `Dockerfile` change the `ROS_IP` and `ROS_MASTER_URI` to the IP of your server, keep in mind that `ROS_MASTER_URI` needs to include the correct port for ROS (11311). The last line of the Dockerfile should look similar to this: `CMD /bin/bash -c "source /opt/ros/kinetic/setup.bash; export ROS_IP=172.31.168.115; export ROS_MASTER_URI="http://172.31.168.115:11311"; roslaunch rosbridge_server rosbridge_websocket.launch unregister_timeout:=999999999"`

Build the Docker image with:

    $ docker build -t ![dockerhub-user]/rosbridge_kinetic:latest .

And finally start the Rosbridge server:

    $ docker run -it --net=host ![dockerhub-user]/rosbridge_kinetic:latest   

### Setup for IP cameras

If IP cameras are being used that support the _RTSP_ protocol, this one needs to be transcoded to ROS-messages which can be imported onto the Autolab interface via the Rosbridge server. Clone the following repository:

    $ git clone git@github.com:duckietown/rtsp-ros-driver.git

Inside the `Dockerfile` change the `ROS_IP` and `ROS_MASTER_URI` to the IP of your server, keep in mind that `ROS_MASTER_URI` needs to include the correct port for ROS (11311). The last line of the Dockerfile should look similar to this: `CMD /bin/bash -c "source /opt/ros/kinetic/setup.bash ; source /home/camera_driver/catkin_ws/devel/setup.bash; export ROS_IP=172.31.168.115; export ROS_MASTER_URI="http://172.31.168.115:11311"; roslaunch rtsp_ros_driver rtsp_driver_node.launch"`

Inside `catkin_ws/src/rtsp_driver_node/launch/rtsp_driver_node.launch` edit the default values of the `hostname`, `port` and `stream` according to your IP camera setup.

Build the Docker image with:

    $ docker build -t ![dockerhub-user]/rtsp_driver_kinetic:latest .

And finally start the Rosbridge server:

    $ docker run -it --net=host ![dockerhub-user]/rtsp_driver_kinetic:latest 

### Parameter setup 

Setting up the different parameters for the Autolab interface is straight forward. Navigate to the `Settings` tab of compose and open the `Package: Autolab control` menu. The following parameters need to be changed:

* **IP Hue Hub** IP of the Philips Hue Hub to control smart-bulbs for environmental control
* **API Key** API Key to interact with the Philips Hue API
* **Number of lightbulbs** Number of lightbulbs used in your setup
* **IP of IPcam's, add up to 4 IP's in a .csv format** IP's of different IP cams used inside the lab, simply seperate them with a comma (up to 4 are supported)
* **Duckietown token** The operator's Duckietown token, needed for submission requests from the AIDO submission server
* **Flask url** URL of your Flask server, most likely `http://![server-hostname].local` will work
* **Flask port** Port used by the Flask server, if left at default, just use port 5050
* **Changelog file** Raw github file that includes the changelog for Duckiebots and Watchtowers. An example can be found [here](https://raw.githubusercontent.com/duckietown/ETHZ-autolab-fleet-roster/webeben_test/changelog/default.yaml)
* **Submission server url** URL of the AIDO submission server, remember to use port 6544
* **Hostname of the logging server** Hostname of the local logging server used to save the necessary ROS messages during an evaluation
* **Username of the logging server, needs passwordless ssh** Username of the logging server, needs passwordless ssh to execute correctly
* **IP of the lab ROS master** IP of the Autolab ROS master where every acquisition-bridge subscribes to

In the `Package: ROS` menu, the following parameters need to be changed:
* **ROSBridge Port** Needs to be set to port 9090

### Changing the map

TODO:

### Changing intial Watchtower positions

TODO:
