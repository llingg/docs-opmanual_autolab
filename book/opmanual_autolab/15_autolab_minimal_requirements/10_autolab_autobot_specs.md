# BUILDING - Autobot specifications and assembly {#autolab-autobot-specs status=ready}

Excerpt: upgrade your Duckiebot to become an Autobot

<div class='requirements' markdown="1">

Requires: a Duckiebot in [DB18 configuration](+opmanual_duckiebot#duckiebot-configurations)

Requires: additional hardware depending on configuration

Results: a Autobot ready to be detected by the localization system

Next Steps: if you have an autocharging area, add the parts for [autocharging](#autocharging-current-collector )

</div>

## Flashing the autobots

For a functional autolab, we strongly recommend using names of the type :

- autobotXX (with XX starting at 01)

The autobot part can be changed, but the numbers at the end make the whole autolab code easier to use and maintain.

To flash the autobots sd cards, follow the instructions [here](+opmanual_duckiebot#setup-duckiebot).

## Adding hardware to the bot

Warning: If you want to use the autocharging feature, you will have to swap the Raspberry Pi to the top part of the Duckiebot. This is due to additional hardware that will be added. So your Duckiebot should look like [](#fig:pre-autocharging-DB). As the batteries do not fit underneath the chassis you will have to get creative about where to place the battery.

Note: If you want to be super safe you might want to add a [Pin protector](https://drive.google.com/open?id=1YrE0E-Qe2v_7X06ddPYgzDtFMYBIbol9) to ensure the pins will not be shorted when the Raspberry Pi is mounted on top of your Duckiebot. You can 3D print the protector with the link provided above or if you do not have a 3D printer available, use one of the many websites that offer 3D printing services such as [sculpteo](https://www.sculpteo.com/en/).

<div figure-id="fig:pre-autocharging-DB">
<img src="images/pre-autocharging-DB.jpg" style="width: 80%"/>
<figcaption>
Pre-flight setup of the Duckiebot if you want to use autocharging.
</figcaption>
</div>


### For localization

#### Material needed for the localization standoff {#material-autobot-localization status=ready}

* 4 standoffs M3 x 50mm for example from [here](https://www.distrelec.ch/en/spacer-bolt-6mm-50-mm-no-brand-distin3060pa-50/p/14843056?queryFromSuggest=true)
* 8 screws M3 * 8mm
* laser cut [top plate](https://drive.google.com/open?id=1LF6UORjYlF0ICI8ZGKwz_oqMJ4QF_Nix)
* printed [April tags](https://drive.google.com/open?id=1B7oAyzrq4CZSOYOZ6KBGFxsMMh1tul2p)


<div figure-id="fig:material_standoff_localization">
<img src="images/material_standoff_localization.jpg" style="width: 80%"/>
<figcaption>
Material needed for the localization standoff.
</figcaption>
</div>


#### Assembly

Note: Do not get confused by having the Raspberry Pi on top in the instructions. If you do not plan to use autocharging, there is no need to have it on top.

First of all, attach the screws and standoffs to the Duckiebot. It is important that you use the same mounting position as we do in [](#fig:standoffs-mounted-autobot) because the localization system assumes the April tag to sit on a certain spot of the Autobot. If you place it differently, the localization will be imprecise.

<div figure-id="fig:standoffs-mounted-autobot-bigpic">
<img src="images/standoffs-mounted-autobot-bigpic.jpg" style="width: 80%"/>
<figcaption>
Standoffs mounted on the Autobot.
</figcaption>
</div>

<div figure-id="fig:standoffs-mounted-autobot">
<img src="images/standoffs-mounted-autobot.jpg" style="width: 80%"/>
<figcaption>
Spacers are moved to the very front of tghe mounting holes.
</figcaption>
</div>

Attach the printed April tag on your top plate. In ETH we print the April tags directly onto self-attaching paper so we don't need to add any glue or similar and can easily remove them if needed.
Here it is also important that you attach the April tag the exact same way as we do in [](#fig:standoff-AT-mounted) for the same reason as above. The April tag needs to be aligned with the engraving and the front edge and have the same orientation.

<div figure-id="fig:standoff-AT-mounted">
<img src="images/standoff-AT-mounted.jpg" style="width: 80%"/>
<figcaption>
April tag mounted on the top plate.
</figcaption>
</div>

You can now attach the top plate to the Autobot. The result should look like in [](#fig:autobot-localization)

<div figure-id="fig:autobot-localization">
<img src="images/autobot-localization.jpg" style="width: 80%"/>
<figcaption>
Autobot ready to be detected by the localization system.
</figcaption>
</div>




### For autocharging {#autocharging-current-collector status=ready}

In order to let a Duckiebot charge in a charger, additional hardware is needed. This piece is called the current collector.

<div class='requirements' markdown="1">

Requires: Material for a single current collector [](#sec:autocharging-current-collector-mat)

Result: A Duckiebot capable of charging [](#fig:capable-Dbot).

</div>

<div figure-id="fig:capable-Dbot">
<img src="20_charging_setup/images/assemblied_dbot.jpg" style="width: 80%"/>
<figcaption>
A charging capable Duckiebot.
</figcaption>
</div>


#### Material needed for a single current collector {#autocharging-current-collector-mat}

* 6 $\times$ [laboratory plug CAT I Ø4mm](https://www.distrelec.ch/en/p/14048007)
* 2 $\times$ 1mm cable, length 30cm
* Autolab add-on board (get in touch on slack to find out how to get them)
* If printer available: $5g$ Material for the 3D printer (cutest color is yellow)
* April tag plate
* 16 $\times$ plastic spacers M2.5 $\times$ 12mm **or** 4 $\times$ spacers M2.5 $\times$ 50mm
* 7 $\times$ screw M2.5 $\times$ 10mm and nut M2.5
* Open ended USB cable 20cm
* Soldering iron and solder

#### Assembly

##### Cut / Order the April tag plate

If **a laser cutter is available**, then laser cut [this file](https://www.thingiverse.com/download:5140588) with the dimensions $110 \times 110mm$ (you probably need to scale it, depending on your programs units).

If **no laser cutter is available**, then order [this file](https://www.thingiverse.com/download:5140588) with the dimensions $110 \times 110mm$ from a page, for example [https://www.sculpteo.com/en/](https://www.sculpteo.com/en/).

### Print / Order the current collector

If **a 3D printer is available**, then [just follow these instructions](https://www.thingiverse.com/thing:2996297#instructions).

If **no 3D printer is available**, then order the printed part from [this site](https://www.shapeways.com/product/G5UASUBU4/megacity-current-collector-standard-version).

##### Put together three laboratory plugs

Take three laboratory plugs and put them together as seen in [](#fig:lp_assembly).

<div figure-id="fig:lp_assembly">
<img src="20_charging_setup/images/lp_assembly.jpg" style="width: 80%"/>
<figcaption>
Three laboratory plugs put together.
</figcaption>
</div>

##### Prepare the current collector soldering

Be sure to have everything ready in [](#fig:assembly_pre_cc)

<div figure-id="fig:assembly_pre_cc">
<img src="images/assembly_pre_cc.jpg" style="width: 80%"/>
<figcaption>
Neccessary parts for the current collector soldering
</figcaption>
</div>

##### Solder the wires

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

##### Optional: Glue the laboratory plugs

If for any reason the laboratory plugs do not fit tightly in the 3D printed part, glue them.

##### Prepare the assembly

Make the parts ready as seen in [](#fig:assembly_current_collector).

<div figure-id="fig:assembly_current_collector">
<img src="images/assembly_current_collector.jpg" style="width: 80%"/>
<figcaption>
Neccessary parts for the assembly.
</figcaption>
</div>

##### Assemble the April tag plate

Assemble the April tag plate by using the acrylic glass, screws and distance keepers as seen in [](#fig:assembled_at_plate)

<div figure-id="fig:assembled_at_plate">
<img src="images/topplate.jpg" style="width: 80%"/>
<figcaption>
The assembled April tag plate
</figcaption>
</div>

##### Mount current collector to April tag plate

Mount the current collector by using three screws and nuts as seen in [](#fig:screwed_current_collector)

<div figure-id="fig:screwed_current_collector">
<img src="images/curr_collector_attach.jpg" style="width: 80%"/>
<figcaption>
The current collector mounted to the April tag plate.
</figcaption>
</div>

##### Plug in the Autolab add-on board

Plug in the Autolab add-on board as seen in [](#fig:plugged_addon_board). Also, screw the cables from the current collector as well as the open ends from the open ended USB cable to the add-on board.

<div figure-id="fig:plugged_addon_board">
<img src="images/plugged_addon_board.jpg" style="width: 80%"/>
<figcaption>
The Autolab add-on board.
</figcaption>
</div>

##### Mount the structure to the Duckiebot

Mount the April tag board with the current collector assembled to a Duckiebot as in [](#fig:result_cc) and [](#fig:mounted_at_plate). Plug in the USB cable to the battery of the Duckiebot.

<div figure-id="fig:mounted_at_plate">
<img src="images/att_topplate.jpg" style="width: 80%"/>
<figcaption>
The April tag plate mounted to a Duckiebot.
</figcaption>
</div>

<div figure-id="fig:result_cc">
<img src="images/assemblied_dbot.jpg" style="width: 80%"/>
<figcaption>
The resulting charging-capable Duckiebot.
</figcaption>
</div>

##### Test your setup

Connect the brass pieces to a 5V voltage source and check if the battery signals that it is charging.
