# Starting the Containers

## For Module 1:

### Start the CSLAM Container

### Start the Charging Manager Container for Module 1

laptop $ docker -H ![HOSTNAME].local run -it --net host --memory="800m" --memory-swap="1.8g" --privileged -v /data:/data --name charging_manager ![CONTAINTER_NAME] 

## For Module 2:

### Charging Manager 

#### Start the TCP Server Container 

laptop $ docker -H ![HOSTNAME].local run -it --net host --memory="800m" --memory-swap="1.8g" --privileged -v /data:/data --name server ![CONTAINTER_NAME] 

#### Start the Charging Manager Container for Module 2

laptop $ docker -H ![HOSTNAME].local run -it --net host --memory="800m" --memory-swap="1.8g" --privileged -v /data:/data --name charging_manager  ![CONTAINTER_NAME] 

### Doorkeeper 

#### Start the CSLAM Container 

#### Start the TCP Client Container 

laptop $ docker -H ![HOSTNAME].local run -it --net host --memory="800m" --memory-swap="1.8g" --privileged -v /data:/data --name client ![CONTAINTER_NAME] 


#### Start the Doorkeeper Container

laptop $ docker -H ![HOSTNAME].local run -it --net host --memory="800m" --memory-swap="1.8g" --privileged -v /data:/data --name doorkeeper ![CONTAINTER_NAME] 
