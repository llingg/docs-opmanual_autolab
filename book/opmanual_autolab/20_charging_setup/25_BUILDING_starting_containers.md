# Starting the Containers {#autocharging-starting-containers status=ready}
>TODO change the image names accordingly after merging
Here you can find instructions on how to run the containers in order to bring the autocharging station into action.

## Instructions for CSLAM 
1) Clone the github repository for CSLAM:

    laptop $ git clone https://github.com/duckietown/duckietown-cslam.git  
    laptop $ cd duckietown-cslam/scripts 

2) The way how CSLAM is used is the following:  
Since the apriltag poses are needed on the device, one has to set the ROS_MASTER to the particular device. Therefore,
change lines in the script _watchtowers-setup.sh_ as follows:

```
ROS_MASTER_HOSTNAME=watchtower22  
ROS_MASTER_IP=192.168.1.176

array=(watchtower22)
```  
3) For autocharging a particular version of CSLAM will be run. Therefore, change the image tag for CSLAM container to autocharge. Make sure that the ACQ_DEVICE_MODE is set appropriately. Since we want to get apriltag poses in real time, this parameter has to ve set to live.


```
docker -H ${array[$index]}.local  run -d \
                                      --name cslam-acquisition \
                                      --restart always \
                                      --network=host \
                                      -e ACQ_DEVICE_MODE=live \
                                      -e ACQ_ROS_MASTER_URI_DEVICE=${array[$index]} \
                                      -e ACQ_ROS_MASTER_URI_DEVICE_IP=127.0.0.1 \
                                      -e ACQ_SERVER_MODE=live \
                                      -e ACQ_ROS_MASTER_URI_SERVER=${ROS_MASTER_HOSTNAME} \
                                      -e ACQ_ROS_MASTER_URI_SERVER_IP=${ROS_MASTER_IP} \
                                      -e ACQ_DEVICE_NAME=${array[$index]} \
                                      -e ACQ_BEAUTIFY=1 \
                                      -e ACQ_STATIONARY_ODOMETRY=0 \
                                      -e ACQ_ODOMETRY_UPDATE_RATE=0 \
                                      -e ACQ_POSES_UPDATE_RATE=15 \
                                      -e ACQ_TEST_STREAM=1 \
                                      -e ACQ_TOPIC_VELOCITY_TO_POSE=velocity_to_pose_node/pose \
                                      -e ACQ_TOPIC_RAW=camera_node/image/compressed \
                                      -e ACQ_APRILTAG_QUAD_DECIMATE=2.0 \
                                      duckietown/cslam-acquisition:autocharge || echo "ERROR: Starting cslam-acquisition on ${array[$index]} failed. Probably this Watchtower wasn't configured properly or we can't connect via the network."
```

4) Run the script 

    laptop $ source watchtowers-setup.sh 
  
After starting the container, make sure it is running. You have to see logs in CSLAM container as following:

```
...
[INFO/serverSideProcess] Published pose for tag 327 in sequence 10
[INFO/serverSideProcess] Published pose for tag 334 in sequence 10
[INFO/serverSideProcess] Published pose for tag 360 in sequence 10
[INFO/serverSideProcess] Published pose for tag 327 in sequence 11
...

```


## For Module 1:

### Start the CSLAM Container
Start the CSLAM container according to the instructions above.

### Start the Charging Manager Container for Module 1

    laptop $ docker -H ![HOSTNAME].local run -it --net host --memory="800m" --memory-swap="1.8g" --privileged -v /data:/data --name charging_manager ![CONTAINTER_NAME] 

## For Module 2:

### Charging Manager  
On the charging manager you have to start the following containers: 

#### Start the TCP Server Container 

First clone the github repository for TCP server and then change the YAML file in it. There you have to change the IP address to the IP address of your charging manager:

    laptop $ git clone https://github.com/alifahriander/tcp_server.git
    cd tcp_server/docker 

Now change the IP address in default.yaml.  
Then build, push and run the tcp_server container 

    laptop $ docker build --rm -f "Dockerfile" -t IMAGE_NAME  
    laptop $ docker push IMAGE_NAME  
    laptop $ laptop $docker -H HOSTNAME.local pull IMAGE_NAME  
    laptop $ docker -H hostname.local run -it --net host --memory="800m" --memory-swap="1.8g" --privileged -v /data:/data --name CONTAINER_NAME IMAGE_NAME


#### Start the Charging Manager Container for Module 2

    laptop $ docker -H ![HOSTNAME].local run -it --net host --memory="800m" --memory-swap="1.8g" --privileged -v /data:/data --name charging_manager  anderalii/charging_manager:module2

### Doorkeeper 

#### Start the CSLAM Container  
Start the CSLAM container according to the instructions above.

#### Start the TCP Client Container 

First clone the github repository for TCP client and then change the YAML file in it. There you have to change the IP address to the IP address of your charging manager:

    laptop $ git clone https://github.com/alifahriander/tcp_client.git
    cd tcp_server/docker 

Now change the IP address in default.yaml.  
Then build, push and run the tcp_server container 

    laptop $ docker build --rm -f "Dockerfile" -t IMAGE_NAME  
    laptop $ docker push IMAGE_NAME  
    laptop $ laptop $docker -H HOSTNAME.local pull IMAGE_NAME  
    laptop $ docker -H hostname.local run -it --net host --memory="800m" --memory-swap="1.8g" --privileged -v /data:/data --name CONTAINER_NAME IMAGE_NAME  


#### Start the Doorkeeper Container  
Use the doorkeeper container you have run for setting up the reference tags 

    laptop $ docker -H ![HOSTNAME].local run -it --net host --memory="800m" --memory-swap="1.8g" --privileged -v /data:/data --name doorkeeper ![CONTAINTER_NAME] 
