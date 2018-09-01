# Software architecture {#autocharging-software-architecture status=draft}

Operating a Duckiebot inside a megacity requires software which can switch from state to state. In this section, we describe how we have fit the maintenance code into the bigger picture.

## transition of states

As soon as the script megacity is launched, a Duckiebot is placed into the city and is able to drive around. A timer, the charge estimation algorithm or a human being triggers a topic called GO_TO_CHARGING from the maintenance control node in order to recognize the time when we need to put the Duckiebot into the charging area. When this state is switched from NONE to WAY_TO_MAINTENANCE, the Duckiebot is guided towards the entrance of the maintenance area by a fleet management algorithm. Having arrived at the entrance, this state will get switched to WAY_TO_CHARGING. The Duckiebot request a free charging spot from a TCP-server. After some time the Duckiebot receives a free spot and is guided towards the given charger and enters it. At this point a transition of state from WAY_TO_CHARGING to CHARGING follows and the finite state machine state switches to IN_CHARGING_AREA. These states mean that the Duckiebot is inside the charger and that it will keep distance from other Duckiebots queued up there. As soon as the Duckiebot sees a red line at the end of a charger the finite state is switched to CHARGING_FIRST_IN_LINE. At this given point of time the Duckiebot is the first one being able to leave the charger and it only needs to wait until it gets fully charged or someone triggers it to exit the charger and free another charging spot. By the time a Duckiebot receives a ready to go from a timer, the charge estimation algorithm or a human being two things happens: the finite state switches to LANE_FOLLOWING which makes the Duckiebot able to drive and the maintenance control node switches to WAY_TO_CITY. The Duckiebot is now guided out of the maintenance area. If the exit is reached, the maintenance control node is switched to NONE and the Duckiebot is again able to drive around in the city.


<div figure-id="fig:software_architec">
<img src="images/software_arch.jpg" style="width: 80%"/>
<figcaption>
Graph of software architecture.
</figcaption>
</div>
