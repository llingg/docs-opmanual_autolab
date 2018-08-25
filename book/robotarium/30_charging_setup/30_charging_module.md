# Charging module {#autocharging-charging-module status=draft}

For the construction of a charging module, you have many degrees of freedom. This includes the choice of material of the wooden structure (may be metal as well), the type of connection between the structure elements (screws, glue, nails), the length of the cables and many more.

In the following, you find the description on how we did it in Zurich.

## Material for one charging module

In this list, $X$ will denote the number of charging rail tiles in a charging module. \emph{Reminder}: One charging rail tile can fit $3$ Duckiebots ($1.5$ per lane).

* $8 \times$ brass rod $Ø4mm$, length ($10cm + X \times 59cm$)
* $(X + 1)$ $\times$ wooden structure top piece ($2 \times 2 \times 90cm$)
* $(2 \times (X + 1))$ $\times$ wooden structure side piece ($2 \times 2 \times 20cm$)
* $(2 \times (X + 1))$ $\times$ wooden structure floor piece ($10 \times 10 \times 1cm$)
* $(4 \times (X + 1))$ $\times$ woodscrew for high voltage pole, i.e. screw $Ø3.2 \times 40mm$
* $(8 \times (X + 1))$ $\times$ screw $M3 \times 30mm$ and $M3$ nuts
* $(2 \times (X + 1))$ $\times$ insulator - [self-print here](https://www.thingiverse.com/thing:2996297/files) or [order here](https://www.shapeways.com/product/QN3HP9EAH/megacity-insulator)
* Drill $Ø4mm$ and $Ø6mm$
* $\frac {1}{per charger} \times $ power supply which enables you to drive 5V and 30Amps
* $\frac{1}{per power supply} \times$ power cable
* $\frac{3}{per power supply} \times$ cable-end-sleeve
* $18 \times$ cable shoes $Ø4mm$
* $4 \times$ M4 screw 10mm and M4 Nut
* crimping tool
* $Ø4mm \times 6m$ red cable
* $Ø4mm \times 6m$ black cable
* $8 \times$ [laboratory plug CAT I Ø4mm](https://www.distrelec.ch/en/p/14048007)


## Building a charging module


### Assemble the wooden structure

Assemble the wooden structure as in [](#fig:assembled_wooden_struc). This part may differ from our reference part. The important and neccessary specifications are: (i) the structure must be larger than one tile such that a road (with margins on both sides) may fit underneath and (ii) the space between the tile and the bottom part of the crossbar must be exactly 21cm (see [](#fig:hv_pole_drawing)).

<div figure-id="fig:assembled_wooden_struc">
<img src="images/assembled_wooden_struc.jpg" style="width: 80%"/>
<figcaption>
An assembled wodden structure.
</figcaption>
</div>


### Prepare for mounting the insulators

Make sure you have the parts ready seen in [](#fig:assembly_hv_pole).

<div figure-id="fig:assembly_hv_pole">
<img src="images/assembly_hv_pole.jpg" style="width: 80%"/>
<figcaption>
Parts needed to prepare and assemble a high voltage pole.
</figcaption>
</div>

### Drill the holes

Drill 3mm holes such that the insulators will be centered after mounting, seen in [](#fig:hv_pole_drawing)

<div figure-id="fig:hv_pole_drawing">
<img src="images/hv_pole_drawing.png" style="width: 80%"/>
<figcaption>
2D sketch of a high voltage pole.
</figcaption>
</div>

The 6mm holes (depth roughly 5mm) are optional and act as a hideout for the screw heads. The resulting holes should look like [](#fig:drilling_hole_hv_pole).

<div figure-id="fig:drilling_hole_hv_pole">
<img src="images/drilling_hole_hv_pole.jpg" style="width: 80%"/>
<figcaption>
Drilled holes.
</figcaption>
</div>

### Mount the insulator

Mount the insulator 3D prints as seen in [](#fig:assembled_insulator) and [](#fig:hidden_screw).

<div figure-id="fig:assembled_insulator">
<img src="images/assembled_insulator.jpg" style="width: 80%"/>
<figcaption>
The assembled insulator.
</figcaption>
</div>

<div figure-id="fig:hidden_screw">
<img src="images/hidden_screw.jpg" style="width: 80%"/>
<figcaption>
How the screw head is hidden.
</figcaption>
</div>


### Fix the high voltage poles to tiles

Use double-sided tape to mount the high voltage poles to the tiles ([](#fig:glued_wooden_structure)). Make sure that the high voltage poles are aligned throughout the whole charging module.


### Bend brass rails and mount them

Bend the charging rails 5cm on both sides (in the same direction) to ensure that Duckiebots do not get stuck when arriving at the charging rail tiles ([](#fig:glued_wooden_structure)).

Then, clip the brass rails into the insulators.

<div figure-id="fig:glued_wooden_structure">
<img src="images/glued_wooden_structure.jpg" style="width: 100%"/>
<figcaption>
Glued high voltage poles with clipped in charging rails.
</figcaption>
</div>

### Solder laboratory plugs

Strip the insulation of the four red and four black cables on both sides with a wire stripper off. Then solder four red and four black cables each to a laboratory plug as seen in [](#fig:soldered_plugs). These cables should be approximately 20-25cm long.

<div figure-id="fig:soldered_plugs">
<img src="images/soldered_plugs.jpg" style="width: 100%"/>
<figcaption>
Soldered laboratory plugs to the cables.
</figcaption>
</div>

### Attach cable shoes
Mount a cable shoe $Ø4-6mm$ with a crimping tool on the other side of these cables you have soldered. Then connect two red and two black cables respectively together with another cable shoe with a M4 screw and a M4 nut as seen in [](#fig:connected_cables). Then connect to the third cable shoe the corresponding red/black cable which will go towards the power supply. This third cable should be long enough to reach the power supply. Also attach to the end of the third cable a cable shoe.

<div figure-id="fig:connected_cables">
<img src="images/cable_shoe_connection.jpg" style="width: 100%"/>
<figcaption>
Connection of the cables to the rails.
</figcaption>
</div>

### Plug the soldered laboratory plug cable to the brass rail
 Connect the laboratory plugs to the bended ends of the charging rails as seen in [](#fig:mounted_plugs). The cables of the brass rods must be polarized as seen in [](#fig:polarity_graph). Make sure that you connect the four rods on the left to one power supply and another four rods on the right to the other power supply.


<div figure-id="fig:mounted_plugs">
<img src="images/mounted_plugs.jpg" style="width: 100%"/>
<figcaption>
Connection between cables of power supply and charging rails.
</figcaption>
</div>


<div figure-id="fig:polarity_graph">
<img src="images/polarity_graph.png" style="width: 100%"/>
<figcaption>
The polarities of the brass rods.
</figcaption>
</div>

### Prepare the power cable for the power supply
Take the power cable and strip the isolation off. Then attach a cable-end-sleeve with the crimping tool as seen in [](#fig:power_cable). Then connect the prepared cable to the power supply exactly as it is shown in [](#fig:attached_power_cable).

Note:
**It is important that ground, phase and neutral phase is connected the right way, so the colors need to match**.

<div figure-id="fig:power_cable">
<img src="images/power_cable.jpg" style="width: 100%"/>
<figcaption>
One end of the power cable before and after.
</figcaption>
</div>

<div figure-id="fig:attached_power_cable">
<img src="images/attached_power_cable.jpg" style="width: 100%"/>
<figcaption>
Attached power cable to the power supply.
</figcaption>
</div>

### Attach to power source
Connect the power supply to the rails. Red cable to V+ and black cable to V- as shown in [](#fig:powersupply). Make also a connection between the two power supplies ground, in order to have a common ground.

<div figure-id="fig:powersupply">
<img src="images/powersupply.jpg" style="width: 80%"/>
<figcaption>
The connected power supply.
</figcaption>
</div>

### Adjust the output voltage of the power source
Turn on the power supply by plugging in the power cable. There is a voltage regulator next to the V+ connection - there you can adjust the voltage. Take a screw driver and a multimeter and measure the Voltage across V+ and V-. The Voltage should be adjusted to 5.5V.

<div figure-id="fig:powersupply_cc">
<img src="images/powersupply_cc.jpg" style="width: 80%"/>
<figcaption>
Voltage regulator seen as the plastic screw.
</figcaption>
</div>

### Test your setup

Place an assemblied Duckiebot which is capable of charging underneath the charging rails and see if the battery is going to charge.
