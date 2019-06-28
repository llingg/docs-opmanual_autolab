# Definitions {#autocharging-definitions status=beta}

<div class='requirements' markdown="1">

Requires: put requirements here

Results: put result here

Next Steps: put next steps here
</div>


## Maintenance area

The city area and the charging/calibration area of the Autolab are strictly separated by a single road tile. Every tile whose purpose is the servicing of Autobots is part of the maintenance area. This includes every intersection and road which guides the Autobot from the maintenance entrance to a charging module and back.

## Charging area

A charging area is the combination of multiple charging modules ([](#sec:autocharging-definitions-module)) and intersections, straight and curved tiles which connect the charging modules to the maintenance area entrance. [](#fig:conventions) shows a charging area.

Inside a charging area, Autobots drive in a charger ([](#sec:autocharging-definitions-charger)) and charge their battery by making contact between the attached current collector ([](#sec:autocharging-definitions-currcol)) and the above mounted charging rails ([](#sec:autocharging-definitions-chargingrail)).



## Current collector {#autocharging-definitions-currcol}

The current collector [](#fig:soldered_cc) is a flexible shaft mounted on top of an Autobot. Its purpose is to make contact with the charging rails.

<div figure-id="fig:db_w_cc">
<img src="images/result_current_collector.jpg" style="width: 80%"/>
<figcaption>
An Autobot with a current collector.
</figcaption>
</div>

## Charging rail {#autocharging-definitions-chargingrail}

A charging rail is a brass tube mounted over tiles of a charging module ([](#sec:autocharging-definitions-module)) with the help of high voltage poles ([](#sec:autocharging-definitions-hvp)).

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

The insulator connects the charging rails to the high voltage pole structure.

<div figure-id="fig:insulator">
<img src="images/insulator.jpg" style="width: 80%"/>
<figcaption>
An insulator.
</figcaption>
</div>

## Charging rail tiles {#autocharging-definitions-railtiles}

Charging rail tiles are tiles with charging rails. Autobots can charge in both directions. Each charging rail tile has $8$ brass rails. See [](#fig:conventions).

## Charging module {#autocharging-definitions-module}

A charging module describes the combination of a charging rail and all connected straight and curved tiles up to the next intersection. See [](#fig:conventions).

## Charger {#autocharging-definitions-charger}

A charger describes one single lane of a charging module. See [](#fig:conventions).

<div figure-id="fig:conventions">
<img src="images/conventions.png" style="width: 100%"/>
<figcaption>
Figure showing naming Conventions
</figcaption>
</div>
