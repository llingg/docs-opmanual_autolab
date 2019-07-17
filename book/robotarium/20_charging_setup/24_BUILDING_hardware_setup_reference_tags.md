# Setup of Reference Tags {#autocharging-reference-tags status=Beta}

This part helps you to place apriltags on the intersections they are needed. They are used for detecting Duckiebots on either maintenance intersection for Module 1 or charger intersections for Module 2. To seperate the apriltags that are only used for charging management, we call them reference tags.

## Steps


1. Allocate the watchtowers near to the intersection in order to let it see all 3 directions: entrance/exit to the intersection and two directions to two seperate chargers. See[]()

2. Before setting up the reference tags, please first start the CSLAM container and then either charging manager container for module 1 with the following command :

laptop $  docker -H ![HOSTNAME].local run -it --net host --memory="800m" --memory-swap="1.8g" --privileged -v /data:/data --name charging_manager ![charging_manager_container]

or doorkeeper container for module 2 with the following command:  

laptop $  docker -H ![HOSTNAME].local run -it --net host --memory="800m" --memory-swap="1.8g" --privileged -v /data:/data --name doorkeeper ![doorkeeper]


3. In order to observe what the camera type the following commands below in: 

    laptop $ dts start_gui_tools ![HOSTNAME]

    container $ rqt_image_view 
    
    Now select the topic _acquisition_node/test_video_ .
    You have to get an image as following:

    
>TODO: IMAGE  intersection 
<div figure-id="fig:doorkeeper_intersection">
<img src="images/apriltags_def.png" style="width: 80%"/>
<figcaption>
View from doorkeeper on charger intersection
</figcaption>
</div>


4. In the picture above you can see that the lane on the right side is defined as direction 1 and on the lower left side as direction 2. Define which charger the direction leads. For example in our case direction 1 leads to charger 2 and direction 2 leads to charger 4. Then, choose apriltags under the scope of camera in order to assign them as reference apriltags, for example in this picture the reference tags are selected as following:  
    * entrance tag : 374
    * exit tag : 238 
    * direction 1 tag : 361
    * direction 2 tag : 347 

    Please note them down. It will be recommended to choose ground apriltags for the sake of next step, but you are allowed to use traffic signs as reference tag, if necessary. 


# TODO: IMAGE intersection with annotation

5. Go into the container   

    laptop $ docker -H ![HOSTNAME].local exec -it ![CONTAINER_NAME] /bin/bash 
    
    and list all the parameters with 

    container $ rosparam list 

    Now you have to change 6 parameters according to your selections in step 4.

    First, change direction parameters:

    container $ rosparam set ![HOSTNAME]/.../direction1 ![CHARGER_ID]
    container $ rosparam set ![HOSTNAME]/.../direction2 ![CHARGER_ID]

    Secondly, change the april tag parameters: 

    container $ rosparam set ![HOSTNAME]/.../direction1_tag ![direction1_tag]
    container $ rosparam set ![HOSTNAME]/.../direction2_tag ![direction2_tag]
    container $ rosparam set ![HOSTNAME]/.../entrance ![entrance]
    container $ rosparam set ![HOSTNAME]/.../exit ![exit]

    If you can see that your changes on your logs in STATIC_TAGS, you have accomplished this step. 
    
# TODO:Screenshot static tags logs doorkeeper

6. First of all, take a duckiebot and place it to the entrance of the intersection.   
Now in the logs of charging manager/doorkeeper container you will see the following:

...  
# TODO: Screenshot  logs of doorkeeper
(duckiebot apriltag is near to entrance/exit apriltag)  
...  

If it is not the case, please replace the reference tag which is at the moment the closest neighbor apriltag to the duckiebot's apriltag further from the charger intersection entrance along the lane it is located. In this example, you can see that the apriltag 361 is far from the intersection entrance and it is near to the charger exit.

7. Repeat the previous step for every reference apriltag 
8. Test and verify that reference apriltags' placement works. In order to do that, follow the instructions below:
    1. Start the _indefinite navigation demo_

    laptop $ dts duckiebot demo --demo_name indefinite_navigation --duckiebot_name DUCKIEBOT_NAME --package_name duckietown_demos

    2. Place the duckiebot just before the intersection, the direction it is on does not matter. 
    3. Start the autonomous mode  

        laptop $ dts duckiebot keyboard_control DUCKIEBOT_NAME  
        
        and press _A_
    4. Observe the logs of charging manager/doorkeeper  
    You have to see similar logs like this:
    Repeat this experiment for other directions. _(During your experiments you may see some other logs then the one below, please ignore them. They are not setup relevant)_
# TODO: LOGS DUCKİEBOT ON WAY 



