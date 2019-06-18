# BUILDING - Plan your maintenance area {#autocharging-planning status=beta}

We highly recommend that the maintenance area fulfills the specifications of Duckietown. If needed, U-turns can be used.

Charging modules are scalable structures. Under good light conditions, roughly $3$ Duckiebots fit in one tile. To ensure robustness, multiple charging modules should be used - that way, if a Duckiebot gets stuck for any reason, the affected charging module can be closed while all others can still be used.

## Decide how many Duckiebots need to fit

Charging of a Duckiebot takes roughly the same time as discharging it. However, currently there is no way to park Duckiebots. Therefore it is recommended to be able to fit every Duckiebot inside the charging area.

## Calculate the amount of charging rail tiles

$ ChargingTiles = \frac{Duckiebots}{3}$



## Plan the charging area

**In between an intersection and a charging rail tile, there needs to be at least one straight.** This restriction comes from the fact that the current collector may not touch a charging rail while traversing through an intersection to avoid additional disturbances.

<div figure-id="fig:charging_area_example">
<img src="images/charging_area_example.png" style="width: 80%"/>
<figcaption>
An example charging area which fulfills the specifications. This charging area can fit $3 \times 10 = 30$ Duckiebots.
</figcaption>
</div>

The charging area in [](#fig:charging_area_example) fulfills the specifications and has four chargers (two per module).

## Calculate the amount of power supplies

The charging current of a Duckiebot is approximately 2Amps at 5V. By using a 5v30A power supply, you are able to charge 15 Duckiebots. However, we recommend to use one power supply per charger. That way, you may use shorter cables and therefore have less voltage drop.
