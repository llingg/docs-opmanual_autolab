# Current collector {#autocharging-current-collector status=beta}

In order to let a Duckiebot charge in a charger, additional hardware is needed. This piece is called the current collector.

## Materials for a single current collector

* $6 \times$ [laboratory plug CAT I Ø4mm](https://www.distrelec.ch/en/p/14048007)
* $2 \times$ 1mm cable, length 30cm
* Robotarium add-on board
* If printer available: $5g$ Material for the 3D printer (cutest color is yellow)
* April tag plate
* $16 \times$ plastic spacers $M2.5 \times 12mm$ **or** $4 \times$ spacers $M2.5 \times 50mm$
* $7 \times$ screw $M2.5 \times 10mm$ and nut $M2.5$
* Soldering iron and solder

## Build a charging capable Duckiebot

### Cut / Order the april tag plate

If **a laser cutter is available**, then laser cut [this file](https://www.thingiverse.com/download:5140588) with the dimensions $110 \times 110mm$ (you probably need to scale it, depending on your programs units).

If **no laser cutter is available**, then order [this file](https://www.thingiverse.com/download:5140588) with the dimensions $110 \times 110mm$ from a page, for example [https://www.sculpteo.com/en/](https://www.sculpteo.com/en/).

### Print / Order the current collector

If **a 3D printer is available**, then [just follow these instructions](https://www.thingiverse.com/thing:2996297#instructions).

If **no 3D printer is available**, then order the printed part from [this site](https://www.shapeways.com/product/G5UASUBU4/megacity-current-collector-standard-version).

### Put together three laboratory plugs

Take three laboratory plugs and put them together as seen in [](#fig:lp_assembly).

<div figure-id="fig:lp_assembly">
<img src="images/lp_assembly.jpg" style="width: 80%"/>
<figcaption>
Three laboratory plugs put together.
</figcaption>
</div>

### Prepare the current collector soldering

Be sure to have everything ready in [](#fig:assembly_pre_cc)

<div figure-id="fig:assembly_pre_cc">
<img src="images/assembly_pre_cc.jpg" style="width: 80%"/>
<figcaption>
Neccessary parts for the current collector soldering
</figcaption>
</div>

### Solder the wires

Solder the wires to the laboratory plugs as seen in [](#fig:soldered_lp).

<div figure-id="fig:soldered_lp">
<img src="images/soldered_lp.jpg" style="width: 80%"/>
<figcaption>
A wire soldered to the laboratory plugs.
</figcaption>
</div>

Put the cables through the 3D printed part as seen in [](#fig:soldered_cc).

<div figure-id="fig:soldered_cc">
<img src="images/soldered_cc.jpg" style="width: 80%"/>
<figcaption>
A current collector during the soldering process.
</figcaption>
</div>

### Optional: Glue the laboratory plugs

If for any reason the laboratory plugs do not fit tightly in the 3D printed part, glue them.

### Prepare the assembly

Make the parts ready as seen in [](#fig:assembly_current_collector).

<div figure-id="fig:assembly_current_collector">
<img src="images/assembly_current_collector.jpg" style="width: 80%"/>
<figcaption>
Neccessary parts for the assembly.
</figcaption>
</div>

### Assemble the april tag plate

Assemble the april tag plate by using the acrylic glass, screws and distance keepers as seen in [](#fig:assembled_at_plate)

<div figure-id="fig:assembled_at_plate">
<img src="images/assembled_duckietop.jpg" style="width: 80%"/>
<figcaption>
The assembled april tag plate
</figcaption>
</div>

### Mount current collector to april tag plate

Mount the current collector by using three screws and nuts as seen in [](#fig:screwed_current_collector)

<div figure-id="fig:screwed_current_collector">
<img src="images/screwed_current_collector.jpg" style="width: 80%"/>
<figcaption>
The current collector mounted to the april tag plate.
</figcaption>
</div>

### Plug in the robotarium add-on board

Plug in the robotarium add-on board as seen in [](#fig:plugged_addon_board)

<div figure-id="fig:plugged_addon_board">
<img src="images/plugged_addon_board.jpg" style="width: 80%"/>
<figcaption>
The robotarium add-on board.
</figcaption>
</div>

### Mount the structure to the Duckiebot

Mount the april tag board with the current collector assembled to a Duckiebot as in [](#fig:result_cc) and [](#fig:mounted_at_plate). Plug in the USB cable to the battery of the Duckiebot.

<div figure-id="fig:mounted_at_plate">
<img src="images/mounted_duckietop.jpg" style="width: 80%"/>
<figcaption>
The april tag plate mounted to a Duckiebot.
</figcaption>
</div>

<div figure-id="fig:result_cc">
<img src="images/result_current_collector.jpg" style="width: 80%"/>
<figcaption>
The resulting charging-capable Duckiebot.
</figcaption>
</div>

### Test your setup

Connect the brass pieces to a 5V voltage source and check if the battery signals that it is charging.
