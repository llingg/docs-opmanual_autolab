# Setup of Reference Tags {#autocharging-reference-tags status=beta}

(First, we seperate the apriltags that are only used for charger management with the normal ground apriltags and we call them reference tags.)

This part helps you to place reference tags on the intersections they are needed. They are used for detecting Duckiebots on an intersection. 
For module 1 the charging manager will be detecting Duckiebots, so you have to place the reference tags on the maintenance intersection following the instructions below.   
For module 2 Duckiebots are detected on the charger intersections by the doorkeepers from the apriltag on their apriltag plate, so you must place the reference tags on the charger intersections following the instructions below.  


## Steps

0. Take 4 apriltags and place them on the intersection they are needed. Note down the apriltag IDs you are using.

1. Allocate the watchtowers on the edge to the intersection in order to let it see all 3 directions: entrance/exit to the intersection and two directions to two seperate chargers.


2. In Step 2 we will start the CSLAM container.

If you are using module 1, the charging manager will be responsible for apriltag detection. Therefore, you have to run the CSLAM container on charging manager.   
If you are using module 2, the doorkeepers will be responsible for detecting apriltags. Hence, CSLAM container must be started on doorkeepers and not on the charging manager.  

Use the following command line to run the CSLAM container 

0) Clone the github repository for CSLAM:

    laptop $ git clone https://github.com/duckietown/duckietown-cslam.git
    lapotp $ cd duckietown-cslam/scripts 
    
1) Open the file watchtowers_setup.sh . In the file set the ROS_MASTER_HOSTNAME and ROS_MASTER_IP to charging manager's hostname and IP (for module 1) or doorkeeper's hostname and IP (for module 2). Change the array to the hostname. An example:

```
ROS_MASTER_HOSTNAME=watchtower22
ROS_MASTER_IP=192.168.1.176

array=(watchtower22)
```  
Now change the image tag on the last line to autocharge. The last command in the file should be like this:

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
                                      duckietown/cslam-acquisition:autocharge || echo "ERROR: Starting cslam-acquisition on ${array[$index]} failed. Probably this watchtower wasn't configured properly or we can't connect via the network."
```
2) Run the script 

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

3) Now you are going build and run containers which are responsible to interpret the apriltag poses of duckiebots. In order to do that, use the commands : 

For module 1:

    laptop $ git clone https://github.com/alifahriander/charging_manager_module1.git
    laptop $ cd charging_manager_module1/docker


For module 2:

    laptop $ git clone https://github.com/alifahriander/doorkeeper.git
    laptop $ cd doorkeeper/docker 

In the _docker_ directory you find a YAML file. There you can find the parameters relevant for charging manager or doorkeeper. You have to change the following parameters:  
* direction1  
* direction2  
* direction1_tag  
* direction2_tag  
* entrance  
* exit    

Now it is explained how these parameters are defined.  

<div figure-id="fig:doorkeeper_intersection">
<img src="images/apriltags_def.png" style="width: 80%"/>
<figcaption>
View from doorkeeper on charger intersection
</figcaption>
</div>

In the picture above you can see that the lane on the right side is defined as direction 1 and on the lower left side as direction 2. Define to which charger the direction leads. For example in our case direction 1 leads to charger 2 and direction 2 leads to charger 4. Therefore, according to this picture we have to define direction1 as 2 and direction2 as 4  
Then, choose apriltags under the scope of camera in order to assign them as reference tags, for example in this picture the reference tags are selected as following:  

    * entrance tag : 374
    * exit tag : 238 
    * direction1_tag : 361
    * direction2_tag : 347 
    
If you want to see which apriltags your camera sees, use these command lines:  

    laptop $ dts start_gui_tools ![HOSTNAME]
    container $ echo "![HOST_IP] ![HOSTNAME]" >> /etc/hosts   
    container $ rqt_image_view 
    
Then select the topic /poses_acquisition/test_video/HOSTNAME/compressed  
Select the apriltags such that every selected apriltag represents one direction as in the picture above. If it is necessary to choose traffic sign apriltags, you may select them as reference tags.

Type in the parameters to the YAML file.

Now you have to build, push and run the container

    laptop $ docker build --rm -f "Dockerfile" -t IMAGE_NAME
    laptop $ docker push IMAGE_NAME
    laptop $ docker -H HOSTNAME.local pull IMAGE_NAME
    laptop $ docker -H hostname.local run -it --net host --memory="800m" --memory-swap="1.8g" --privileged -v /data:/data --name CONTAINER_NAME IMAGE_NAME

You can check the logs of the container, You have to see the following logs periodically:

```
...
[INFO] [1563805663.275686]: ###########################
[INFO] [1563805663.288087]: STATIC AT:{'374': {'position': x: 1217.38195801
y: 527.410217285
z: 0}, '238': {'position': x: 252.730285645
y: 602.758789062
z: 0}, '361': {'position': x: 518.172912598
y: 229.96383667
z: 0}, '347': {'position': x: 283.221954346
y: 217.282211304
z: 0}}
[INFO] [1563805663.298289]: MOVING AT:defaultdict(<type 'dict'>, {})
...
``` 

In the logs you see the positions of reference tags are updated periodically. At the beginning all reference tag positions are initialized with 0.0. After you change the above mentioned parameters, you must see that the positions are updated with non-zero values. If that is the case, you accomplished this step.



4. Now you have to place the reference tags such that they refer to a particular direction. In order to do that, take a duckiebot and place it to the entrance of the intersection.   
Now in the logs of charging manager(for module 1)/doorkeeper(for module 2) container you will see that the april tag id is added to a dictionary called MOVING AT(referring the moving apriltags). Its keys refer to the apriltag ids of the duckiebot which arrived to the intersection.

For every apriltag id that is observed on the intersection, there is a dictionary. In it you have some attributes of a duckiebot apriltag: 

    * position :  Position of Duckiebot's apriltag on the image  
    * first_neighbor : First seen closest reference tag to Duckiebot's apriltag  
    * last_neighbor  : Last seen closest reference tag to Duckiebot's apriltag. This attribute will be updated upon receiving april tag positions from the acquisition node  
    * timestamp : The time the information above is saved 
    
Have a look on this log. We moved a duckiebot from entrance to direction 2:

```
...
[INFO] [1563805798.282072]: MOVING AT:defaultdict(<type 'dict'>, {'400': {'first_neighbor': '374', 'last_neighbor': '347', 'timestamp': 1563805796.091526, 'position': x: 748.847106934
y: 468.132141113
z: 0}})
...
``` 
There you see that the first_neighbor is the reference tag with ID 374 corresponding the entrance tag. The last_neighbor argument is tag 347, this is the direction2_tag. So one can infer that duckiebot was moved from entrance to direction 2.

After understanding what the logs mean, look at the last_neighbor argument on the logs. If it corresponds to the entrance reference tag and your duckiebot is located near the entrance reference tag, it means, the placement of entrance reference tag works. 
    
If it is not the case, replace the reference tag which is at the moment the closest neighbor apriltag (last_neighbor in terms of logs)  further from the intersection entrance along the lane it is located. In this example, you can see that the apriltag 361 is far from the intersection entrance and it is near to the charger exit.[](fig:doorkeeper_intersection)

5. Repeat the previous step for every reference tag 
6. Test and verify that reference tags' placement works. In order to do that, follow the instructions below:
    1. Start the _indefinite navigation demo_

    laptop $ dts duckiebot demo --demo_name indefinite_navigation --duckiebot_name DUCKIEBOT_NAME --package_name duckietown_demos

    2. Place the duckiebot just before the intersection, the direction it is on does not matter. 
    3. Start the autonomous mode  

        laptop $ dts duckiebot keyboard_control DUCKIEBOT_NAME  
        
        and press _A_ for switching the Duckiebot to the autonomous mode.
        
    4. Observe the logs of charging manager(for module 1) or doorkeeper (for module 2). You have to see the following: 
    ``` 
    402 is on WAY 2 
    ``` 
    This means, Duckiebot with apriltag ID 402 entered the charger 2.
    
    
    You have to repeat this experiment for other directions and verify that our reference tag placement works. 
    



