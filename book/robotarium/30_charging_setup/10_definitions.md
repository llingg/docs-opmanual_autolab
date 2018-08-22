# Definitions {#autocharging-definitions status=beta}

## Current collector

The current collector is a flexible shaft mounted on top of a Duckiebot. Its purpose is to make contact with the charging rails.

<div figure-id="fig:db_w_cc">
<img src="images/result_current_collector.jpg" style="width: 80%"/>
<figcaption>
A Duckiebot with a current collector.
</figcaption>
</div>

## Charging rail

A charging rail is a brass tube mounted over a Duckietown with the help of high voltage poles.

<div figure-id="fig:brasstube">
<img src="images/brasstube.jpg" style="width: 80%"/>
<figcaption>
A brasstube.
</figcaption>
</div>

## High voltage pole

The purpose of the high voltage pole is to mount the charging rails over the street.

<div figure-id="fig:hv_pole">
<img src="images/hv_pole.jpg" style="width: 80%"/>
<figcaption>
A high voltage pole.
</figcaption>
</div>

## Insulator

The insulator connects the wooden structure with the charging rails.

<div figure-id="fig:insulator">
<img src="images/insulator.jpg" style="width: 80%"/>
<figcaption>
An insulator.
</figcaption>
</div>

## Charging rail tiles

Charging rail tiles are tiles with charging rails. Duckiebots can charge in both directions. Each charging rail tile has $8$ brass rails. See ([](#fig:conventions)).

## Charging module

A charging module describes the combination of a charging rail and all connected straights and curves up to the next intersection. See ([](#fig:conventions)).

## Charger

A charger describes one single lane of a charging module. See ([](#fig:conventions)).


## Charging area

A charging area is the combination of multiple charging modules and intersections, straights and curves which connect the charging modules to the maintenance entrance. ([](#fig:conventions)) shows a charging area.

<div figure-id="fig:conventions">
<img src="images/conventions.png" style="width: 100%"/>
<figcaption>
conventions
</figcaption>
</div>

## Maintenance area

The actual Duckietown city and the charging and calibration area are strictly separated by a single road. Every tile which purpose is the servicing of Duckiebots are part of the maintenance area. This includes every intersection and road which guide the Duckiebot from the maintenance entrance to a charging module and back.
