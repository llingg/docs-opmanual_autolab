# Software architecture {#autocharging-software-architecture status=draft}

Operating a Duckiebot inside a megacity requires software which can switch from state to state. In this section, we describe how we have fit the maintenance code into the bigger picture.

## transition of states

As soon as the script megacity is launched, a Duckiebot is placed into the city and is able to drive around. A timer, the charge estimation algorithm or a human triggers a topic from the maintenance control node in order being able to recognize the time when we need to put the Duckiebot into the charging area. As soon as the state state is switched to $WAY_TO_MAINTENANCE$ the Duckiebot is guided towards the entrance of the maintenance area. Having arrived at the entrance the state will get switched to $WAY_TO_CHARGING$ where the Duckiebot will request a free charging spot and will receive one. The Duckiebot will drive towards the given charger and enters it, this will cause a transition of the Maintenance control node state to $CHARGING$ and the Finite State Machine state to $IN_CHARGING_AREA$. These states means that the Duckiebot is inside the charger and that it will keep distance from other Duckiebots queuing up. As soon as the Duckiebot sees a red line at the end of a charger the finite state is switched to $CHARGING_FIRST_IN_LINE$. At this given point of time the Duckiebot is about to exit the charging area but still has not fully charged yet. By the time a Duckiebot receives a ready to go from a timer, the charge estimation algorithm or a human being two things happens: the finite state switches again to $LANE_FOLLOWING$ and the maitenance control node switches to $WAY_TO_CITY$. The Duckiebot is about to quit the maintenance area and is therefore guided out of it. If the exit is reached the maintenance control node is switched to $NONE$ and the Duckiebot is again able to drive around in the city. 


<div figure-id="fig:software_architec">
<img src="images/software_arch.jpg" style="width: 80%"/>
<figcaption>
Graph of software architecture.
</figcaption>
</div>
