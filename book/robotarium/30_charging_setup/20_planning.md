# Plan your maintenance area {#autocharging-planning status=beta}

We highly recommend that the maintenance area fulfills the specifications of Duckietown. If needed, U-turns can be used.

Charging modules are scalable structures. Under good light conditions, roughly $3$ Duckiebots fit in one tile. To ensure robustness, multiple charging modules should be used - that way, if a Duckiebot gets stuck for any reason, the affected charging module can be closed while all others can still be used.

## Decide how many Duckiebots need to fit

Charging of a Duckiebot takes roughly the same time as discharging it. However, currently there is no way to park Duckiebots. Therefore it is recommended to be able to fit every Duckiebot inside the charging area.

## Calculate the amount of charging rail tiles

$ ChargingTiles = \frac{Duckiebots}{3}$



## Plan the charging area

**In between an intersection and a charging rail tile, there needs to be at least one straight.**

<div figure-id="fig:charging_area_example">
<img src="images/charging_area_example.png" style="width: 80%"/>
<figcaption>
An example charging area which fulfills the specifications. This charging area can fit $3 \times 10 = 30$ Duckiebots.
</figcaption>
</div>

The charging area in [](#fig:charging_area_example) fulfills the specifications and has four chargers (two per module).

## Calculate the amount of power supplies

According to the layout of your charging area and how many bots you want to fit into your town, you need to decide how many power supplies, you will going to use. We have decided to use a power supply which is rated at 5V and deliveres maximally 30Amps.
The charging current of a Duckiebot is approximately 2Amps with the white battery from Ravpower. In order to have a safety margin, we use one power supply for each charger separately and we do not go over a length of 6 tiles. 
