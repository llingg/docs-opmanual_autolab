# Autolab control interface installation {#autolab-control-interface-installation status=ready}

Excerpt: How to setup the web-interface to control the Autolab

<div class='requirements' markdown="1">

Requires: put requirements here

Results: put result here

Next Steps: put next steps here
</div>

<minitoc/>

## Installing the compose interface

### Setup of the workspace

It is recommended to create a folder somewhere you like, that we'll call `Autolab_control` . We will do everything from inside of that folder.

### Launching the compose interface

The Autolab control interface is built with [Compose](http://compose.afdaniele.com/docs/devel/index), described as:

> _A CMS (Content Management System) platform written in PHP that provides functionalities for the fast development of web applications on Linux servers._

To set it up, go into `Autolab_control` and do

    laptop $ git clone https://github.com/afdaniele/compose

    laptop $ docker pull afdaniele/compose:latest

    laptop $ docker run -itd -p 80:80 -v ![/FULL/PATH/TO/Autolab_control/compose/]:/var/www/html/ afdaniele/compose:latest

This will start the \compose\ interface on your computer. The last command makes sure that whatever parameters are set within the interface will be saved, and reused as long as you keep launching the same command. If you run into any issue, visit the [compose website](http://compose.afdaniele.com/docs/devel/index).

Wait up to 10 seconds, then visit the page `http://SERVER_HOSTNAME/` in your browser. `SERVER_HOSTNAME` is the name of the computer you are using. Dont forget the `.local` . For example, on a computer named `autolab_computer_01` , go to `http://autolab_computer_01.local/` .

### Getting the Autolab Control package

First, follow the [initial setup instructions for compose](http://compose.afdaniele.com/docs/devel/first-setup). You can skip step 1, and use the developer mode.

Then, navigate to the __package store__ tab, where you'll see a list of installable packages.

In addition to any package you want, you should install :

* Autolab Control
* ROS
* Data

Once the list is selected, do not forget to actually click install at the top of the page.

### Setting the paremeters in the compose page

In the compose webpage, go to the __settings__ tab, and scroll to the Autolab Control part and fill it.

In the ROS section, set the port to `9090` .

## Setting up the Rosbridge

In order for the web interface to communicate with the rest of the Autolab, you will need a Rosbridge running at all times.

To do so, go to `Autolab_control` and do

    laptop $ git clone git@github.com:duckietown/rosbridge_kinetic.git
    laptop $ cd rosbridge_kinetic
    laptop $ vim docker-compose.yaml

In `docker-compose.yaml` , modify the file to use your server's IP address. Then run

    laptop $ docker-compose up -d

## Setting up the flask server

The flask server is where the control happens. It contains all the functions that are used by the user interface.

To run it, got to `Autolab_control` and do

    laptop $ git clone https://github.com/duckietown/autolab_control_flask_scripts
    laptop $ cd autolab_control_flask_scripts
    laptop $ git checkout daffy
    laptop $ dts devel build -a amd64
    laptop $ vim docker-compose.yaml

Modify the last volume in `docker-compose.yaml` and mount the right path to your [fleet roster](#autolab-fleet-roster).

Then:

    laptop $ docker-compose up -d

## Using the interface

Now, everything should be setup. Go to the `autolab control` tab and enjoy.

