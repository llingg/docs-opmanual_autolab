# Software setup on the Duckiebot {#autocharging-map status=beta}

## Goal

In order to allow the duckiebot to have the autocharging capability. The duckiebot requires to run a container which does the following tasks.

1) The duckiebot has to be guided from any place on the map to the charging area.
2) At the charging area, it understands the instructions of the autocharging manager, which directs it to the appropriate charging lane.
3) From the autocharging entrance the duckiebot follows the correct path to the charging lane
4) In the charging lane it successfully charges.
5) After charging the duckiebot navigates back to the city.

All these tasks are bundled in the megacity image. However, prior to running it, the appropriate paths of the autocharging area have to be setup.

## Preparation

Clone the following repository

    git clone https://github.com/duckietown/rpi-autocharging-demo.git
    cd rpi-autocharging-demo.git
    vim default.yaml

The default.yaml file should have the following outline and structure:

picture of the yaml file

The parameters in the yaml file correspond to the following map:

picture of map

The parameters in the config file are dictionaries - each key (i.e. '150') stands for an april tag ID and maps to either a single direction (i.e. 1) or to multiple directions, stored in a list (i.e. [0,1,2]). The directions, stored as integers, map as follows:

[0, 1, 2] == [LEFT, STRAIGHT, RIGHT].

## Add your own paths

### path_in

The "path_in" parameter of a charger should map traffic sign april tag IDs to a single turn type, which in sum guide the Duckiebot to the charger. In [](#fig:path_to_charger2) an example is given. The path_in of charger 2 would then be

    path_in: {'261': 2, '240': 0}


<div figure-id="fig:path_to_charger2">
<img src="images/path_to_charger2.png" style="width: 80%"/>
<figcaption>
An example path from maintenance entrance to charger 2.
</figcaption>
</div>

### path_to_city

The dictionary "path_to_city" guides a Duckiebot from every possible leaving position (i.e. charger exit, calibration exit) back to the city. In [](#fig:path_to_city), all paths are plotted for an example maintenance area (without a calibration area).

<div figure-id="fig:path_to_city">
<img src="images/path_to_city.png" style="width: 80%"/>
<figcaption>
All possible exit paths from an example maintenance area (without calibration area).
</figcaption>
</div>

### charging_stations: entrances, exits

The dictionary "entrances" and "exits" in the charging_stations parameter contains every entrance / exit to charging stations. This information is needed in the code to determine when a Duckiebot enters or leaves a charger.

### maintenance_entrance / maintenance_exit

This dictionaries define which april tag IDs correspond to the entrance / exit of the maintenance area. This information is needed to detect when a Duckiebot enters or leaves the maintenance area.
