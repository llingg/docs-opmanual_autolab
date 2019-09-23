# Future projects {#autocharging-future status=ready}

There are still multiple tasks which would improve the charging area by a lot. In the following, you find a list of those tasks with a small description, ordered in descending priority.

## Improve the intersection navigation

For traversing through the maintenance area, intersection navigation is a crucial part. With the new Unicorn Intersection Node, the success rate was raised up to over 90%. For a completely autonomous city, this is still way too low.

## Improve the vehicle detection

In order to keep distance to a Duckiebot in front, the vehicle avoidance node detects a circle grid pattern ($7 \times 3$) and adapts the velocity. However, the detection only runs at $2Hz$ and fails sometimes.

## Optimize CPU utilization

Currently, CPU utilization is at 100% for all four cores. The most expensive node seems to be the Image Transformer Node (Anti Instagram) which uses alone 30% of the CPU. This slows down the whole megacity.launch and could be cause for multiple bugs.

## Implement the battery capacity estimation

Currently, the time a Duckiebot drives through the city and stays inside a charger are hard coded variables. With a high enough charging time and a low enough driving time, it is ensured that a Duckiebot never reaches a battery level of 0%. The drawback is that the efficiency in terms of the ratio $\frac {driving time}{charging time}$ is very low. This can be improved by implementing the battery capacity estimation: with the new add-on board, one is able to measure the current going into the battery and therefore integrate it to obtain the battery level.


## Fix the stop line sleep time

In order to avoid stopping at the red line in opposite direction right after an intersection, there is a stop line sleep time implemented. This however does not work robustly - sometimes, that "bad" red line is still detected.


## Consider a cooling system

After operating the Duckiebot for a long time, the Raspberry Pi gets really hot at its interfaces (USB plugs, LAN Port, etc). For a 24/7 operating time that can influence the behavior of the Duckiebot a lot. If one would cool the Duckiebot actively by a little fan, the temperature wouldn't increase that much.


## Adapt autocharging to the newest version of CSLAM

Right now, the charger management runs the version of CSLAM, where apriltag processing is done on raspberry pi. In the newest version of CSLAM, the images of the watchtowers are acquired from the watchtowers and apriltag processing is done on the server computer. This increases the rate of apriltag processing. In order to adapt the usage of CSLAM by charging manager or doorkeeper, one has to let the raspberry pi get the apriltag poses, since they are needed on the device.

## Hardware Redesign

The current collectors are made out of plastic which need to be bend appropriately so they touch the rails well enough to conduct current, but not to hard to not hinder the duckiebot from moving. This solution may be inappropriate in the long term, since the plastic wears out with time. A possible solution could be a hinge with two springs which will hold the current collector in its desired position.
