# DEMO - Light sensors {#light-sensors status=draft}

<div class='requirements' markdown="1">

Requires: A fully operational [Duckietown](+opmanual_duckietown#duckietowns) with [watchtowers](#watchtower-hardware) built to right specs. TODO : add the name of the right specs

Results: Accurate measure of the light field of the Autolab

</div>


This container will show you how to mount the Adafruit TCS34725 sensor on a watchtower and how to correctly plug it in.

## Hardware setup


### Requirements


<div figure-id="fig:wt_sensor1" figure-caption="Pinheaders">
  <img src="opmanual_autolab/images/watchtower/light-sensor/sensor_1.jpg" style='width: 25em; height:auto'/>
</div>

<div figure-id="fig:wt_sensor2" figure-caption="Jumper Cables">
  <img src="opmanual_autolab/images/watchtower/light-sensor/sensor_2.jpg" style='width: 25em; height:auto'/>
</div>

<div figure-id="fig:wt_sensor3" figure-caption="The sensor">
  <img src="opmanual_autolab/images/watchtower/light-sensor/sensor_3.jpg" style='width: 25em; height:auto'/>
</div>

<div figure-id="fig:wt_sensor4" figure-caption="Screws">
  <img src="opmanual_autolab/images/watchtower/light-sensor/sensor_4.jpg" style='width: 25em; height:auto'/>
</div>

<div figure-id="fig:wt_sensor5" figure-caption="Watchtower top plate">
  <img src="opmanual_autolab/images/watchtower/light-sensor/sensor_5.jpg" style='width: 25em; height:auto'/>
</div>



Note: the upper plate of the watchtower need apposite holes to fit the sensor.

### Soldering

The first thing to do is to solder the pin headers to the actual sensor:
To do so the easiest way is to use a breadboard and cut a few pin headers in order to get a nice 90-degree angle between the sensor and the pins.

<div figure-id="fig:wt_sensor6" figure-caption="Sensor on breadboard">
  <img src="opmanual_autolab/images/watchtower/light-sensor/sensor_6.jpg" style='width: 25em; height:auto'/>
</div>


### Fix the sensor to the watchtower plate.
To do so put the pin headers into the big hole and fix it with the screws.

<div figure-id="fig:wt_sensor7" figure-caption="Final assembled sensor">
  <img src="opmanual_autolab/images/watchtower/light-sensor/sensor_7.jpg" style='width: 25em; height:auto'/>
</div>


### Wire the sensor to the watchtower

The best way to figure out how to do this is to always take the sensor and turn it until you can read what is written on it and that will be our basic position.

Plugins on the raspberry-pi: 

o o 1 o o

2 3 4 o 5

Plugins on TCS34725:

o 1 2 4 3 o 5

This is the pin layout, every number corresponds to a wire color (it doesn’t matter which color is which number but just make sure that the wire is connected to the right pin header).


<div figure-id="fig:wt_sensor8" figure-caption="Pinheaders">
  <img src="opmanual_autolab/images/watchtower/light-sensor/sensor_8.jpg" style='width: 25em; height:auto'/>
</div>

<div figure-id="fig:wt_sensor9" figure-caption="Pinheaders">
  <img src="opmanual_autolab/images/watchtower/light-sensor/sensor_9.jpg" style='width: 25em; height:auto'/>
</div>


Now the hardware construction part should be done.

## Software setup

### Requirements
*A sensor which is correctly setup on a running watchtower.
Ideally an external light sensor that measures luminescence in [lux] that can be used as reference.

*An environment where you can control the light intensity, it can also be very small (try to use two light intensities below and above the operating point).

### Introduction
To calibrate the sensor we need to measure the light at two different intensities in order to be able to make a linear approximation. To do so we measure two different light intensities and input the expected values to the sensor and then make a linear approximation.

To do so measure the two intensities by running the container and follow the steps of the instruction provided on the console (don’t forget that you need an external reference sensor as well).

### Run the calibration
You can pull the image of the docker container to the agent

### Check calibration of sensor
You can check the calibration by going to the calibration folder, TODO

## Run

To run the sensor container first you need to pull the image:

‘docker -H HOSTNAME.local pull gian1717/sensor:p2’

And then start the container:

‘docker -H HOSTNAME.local run -it  --net host --privileged --name light-sensor -v /data:/data gian1717/sensor:p2’

If you want to know more:

The whole sensor software is on my GitHub account , on the repository light sensor, sensor calibration.






