# Setup of Reference Tags {#autocharging-reference-tags status=Beta}

First, we seperate the apriltags that are only used for charging management with the normal ground apriltags and we call them reference tags.

This part helps you to place reference tags on the intersections they are needed. They are used for detecting Duckiebots on an intersection. 
For module 1 the charging manager will be detecting Duckiebots, so you have to place the reference tags on the maintenance intersection following the instructions below. 
For module 2 Duckiebots are detected on the charger intersections from the apriltag on their apriltag plate, so you must place the reference tags on the charger intersections following the instructions below.

## Steps


1. Allocate the watchtowers on the edge to the intersection in order to let it see all 3 directions: entrance/exit to the intersection and two directions to two seperate chargers. See[]()

2. Before setting up the reference tags, first start the CSLAM container and then either charging manager container for module 1 with the following command :

laptop $  docker -H ![HOSTNAME].local run -it --net host --memory="800m" --memory-swap="1.8g" --privileged -v /data:/data --name charging_manager ![charging_manager_container]

or doorkeeper container for module 2 with the following command:  

laptop $  docker -H ![HOSTNAME].local run -it --net host --memory="800m" --memory-swap="1.8g" --privileged -v /data:/data --name doorkeeper ![doorkeeper]


3. In order to observe what the camera sees type the following commands below in: 

    laptop $ dts start_gui_tools ![HOSTNAME]

    container $ rqt_image_view 
    
    Now select the topic _acquisition_node/test_video_ .
    
    You have to get an image as following:

<div figure-id="fig:doorkeeper_intersection">
<img src="images/apriltags_def.png" style="width: 80%"/>
<figcaption>
View from doorkeeper on charger intersection
</figcaption>
</div>


4. In the picture above you can see that the lane on the right side is defined as direction 1 and on the lower left side as direction 2. Define which charger the direction leads. For example in our case direction 1 leads to charger 2 and direction 2 leads to charger 4. Then, choose apriltags under the scope of camera in order to assign them as reference tags, for example in this picture the reference tags are selected as following:  

    * entrance tag : 374
    * exit tag : 238 
    * direction 1 tag : 361
    * direction 2 tag : 347 

    Please note them down. It is recommended to choose apriltags on the ground as reference tags for the next step, but you are allowed to use traffic signs as reference tags, if necessary. 

5. Go into the container   

    laptop $ docker -H ![HOSTNAME].local exec -it ![CONTAINER_NAME] /bin/bash 
    
    and list all the parameters with 

    container $ rosparam list 

    
    Now you see a list of all parameters that are used in the device. You have to change 6 parameters according to your selections in step 4.
    For module 1:
    
    First, change direction parameters:

    container $ rosparam set ![HOSTNAME]/![NODE_NAME]/direction1 ![CHARGER_ID]
    container $ rosparam set ![HOSTNAME]/![NODE_NAME]/direction2 ![CHARGER_ID]

    Secondly, change the april tag parameters: 

    container $ rosparam set ![HOSTNAME/![NODE_NAME]/direction1_tag ![direction1_tag]
    container $ rosparam set ![HOSTNAME/![NODE_NAME]/direction2_tag ![direction2_tag]
    container $ rosparam set ![HOSTNAME/![NODE_NAME]/entrance ![entrance]
    container $ rosparam set ![HOSTNAME/![NODE_NAME]/exit ![exit]
    
    For module 2:
    
    First, change direction parameters:

    container $ rosparam set ![HOSTNAME]/![NODE_NAME]/direction1 ![CHARGER_ID]  
    container $ rosparam set ![HOSTNAME]/![NODE_NAME]/direction2 ![CHARGER_ID]  

    Secondly, change the april tag parameters: 

    container $ rosparam set ![HOSTNAME/![NODE_NAME]/direction1_tag ![direction1_tag]  
    container $ rosparam set ![HOSTNAME/![NODE_NAME]/direction2_tag ![direction2_tag]  
    container $ rosparam set ![HOSTNAME/![NODE_NAME]/entrance ![entrance]  
    container $ rosparam set ![HOSTNAME/![NODE_NAME]/exit ![exit]  

    In the logs you see the positions of reference tags are updated periodically. At the beginning all reference tag positions are initialized with 0.0. After you change the above mentioned parameters, you must see that the positions are updated with non-zero values. If that is the case, you accomplished this step. 
    

6. Now you have to place the reference tags such that they refer to a particular direction. In order to do that, take a duckiebot and place it to the entrance of the intersection.   
Now in the logs of charging manager/doorkeeper container you will see the following:

...  
>TODO: Screenshot  logs of doorkeeper
(duckiebot apriltag is near to entrance/exit apriltag)  
...  

In this log you see a python dictionary. Its keys refer to the apriltag ids of the duckiebot which arrived to the intersection. For every apriltag id that is observed on the intersection, there is a dictionary. In it you have some attributes of a duckiebot apriltag:  

    * pose : Position of Duckiebot's apriltag on the image  
    * first_neighbor : First seen closest reference tag to Duckiebot's apriltag  
    * last_neighbor  : Last seen closest reference tag to Duckiebot's apriltag  
    * time : The time the information above is saved  
After understanding what the logs mean, look at the last_neighbor argument on the logs. If it corresponds to the entrance reference tag and your duckiebot is located near the entrance reference tag, it means, the placement of entrance reference tag works. 
    
If it is not the case, replace the reference tag which is at the moment the closest neighbor apriltag (last_neighbor in terms of logs)  further from the intersection entrance along the lane it is located. In this example, you can see that the apriltag 361 is far from the intersection entrance and it is near to the charger exit.[](fig:doorkeeper_intersection)

7. Repeat the previous step for every reference tag 
8. Test and verify that reference tags' placement works. In order to do that, follow the instructions below:
    1. Start the _indefinite navigation demo_

    laptop $ dts duckiebot demo --demo_name indefinite_navigation --duckiebot_name DUCKIEBOT_NAME --package_name duckietown_demos

    2. Place the duckiebot just before the intersection, the direction it is on does not matter. 
    3. Start the autonomous mode  

        laptop $ dts duckiebot keyboard_control DUCKIEBOT_NAME  
        
        and press _A_ for switching the Duckiebot to the autonomous mode.
        
    4. Observe the logs of charging manager(for module 1) or doorkeeper (for module 2) 
    You have 
    Repeat this experiment for other directions. 
    



