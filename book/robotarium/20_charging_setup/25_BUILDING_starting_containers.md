# Starting the Containers {#autocharging-starting-containers status=Beta}

Here you can find instructions on how to run the containers in order to bring the autocharging station into action.

## For Module 1:

### Start the CSLAM Container
>  TODO CSLAM container explanation 

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
