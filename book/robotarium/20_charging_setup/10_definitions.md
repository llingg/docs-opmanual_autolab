# Definitions {#autocharging-definitions status=beta}

## Maintenance area

The actual Duckietown city and the charging and calibration area are strictly separated by a single road. Every tile which purpose is the servicing of Duckiebots is part of the maintenance area. This includes every intersection and road which guides the Duckiebot from the maintenance entrance to a charging module and back.  
Below you can find the definitions of maintenance intersection and charger intersections. You can also see also an example of the placement of charging manager and doorkeepers.[](#fig:int_def)

<div figure-id="fig:int_def">
<img src="images/maintenance_intersection_def.png" style="width: 100%"/>
<figcaption>
Definitions of Intersections and Placement of Charging Manager and Doorkeepers
</figcaption>
</div>

## Charging area

A charging area is the combination of multiple charging modules ([](#sec:autocharging-definitions-module)) and intersections, straights and curves which connect the charging modules to the maintenance entrance. [](#fig:conventions) shows a charging area.

Inside a charging module, Duckiebots drive in a charger ([](#sec:autocharging-definitions-charger)) and charge their battery by making contact between the attached current collector ([](#sec:autocharging-definitions-currcol)) and the above mounted charging rails ([](#sec:autocharging-definitions-chargingrail)).



## Current collector {#autocharging-definitions-currcol}

The current collector [](#fig:soldered_cc) is a flexible shaft mounted on top of a Duckiebot. Its purpose is to make contact with the charging rails.

<div figure-id="fig:db_w_cc">
<img src="images/result_current_collector.jpg" style="width: 80%"/>
<figcaption>
A Duckiebot with a current collector.
</figcaption>
</div>

## Charging rail {#autocharging-definitions-chargingrail}

A charging rail is a brass tube mounted over a Duckietown with the help of high voltage poles ([](#sec:autocharging-definitions-hvp)).

<div figure-id="fig:brasstube">
<img src="images/brasstube.jpg" style="width: 80%"/>
<figcaption>
A brasstube.
</figcaption>
</div>

## High voltage pole {#autocharging-definitions-hvp}

The purpose of the high voltage pole is to mount the charging rails over the street.

<div figure-id="fig:hv_pole">
<img src="images/hv_pole.jpg" style="width: 80%"/>
<figcaption>
A high voltage pole.
</figcaption>
</div>

## Insulator {#autocharging-definitions-insulator}

The insulator connects the charging rails to a overhanging structure.

<div figure-id="fig:insulator">
<img src="images/insulator.jpg" style="width: 80%"/>
<figcaption>
An insulator.
</figcaption>
</div>

## Charging rail tiles {#autocharging-definitions-railtiles}

Charging rail tiles are tiles with charging rails. Duckiebots can charge in both directions. Each charging rail tile has $8$ brass rails. See [](#fig:conventions).

## Charging module {#autocharging-definitions-module}

A charging module describes the combination of a charging rail and all connected straights and curves up to the next intersection. See [](#fig:conventions).

## Charger {#autocharging-definitions-charger}

A charger describes one single lane of a charging module. See [](#fig:conventions).

<div figure-id="fig:conventions">
<img src="images/conventions.png" style="width: 100%"/>
<figcaption>
conventions
</figcaption>
</div>




