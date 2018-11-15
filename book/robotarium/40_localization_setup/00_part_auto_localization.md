# Auto Localization {#part:robotarium-auto-localization}

Maintainer: Chen-Lung "Eric" Lu

The auto-localization system is an important part of AI-DO competition. Since we need to score each team with the performances of their cars, it's necessary to have a system to localize and track the movement of these Duckiebots.

The concept behind the auto-localization is by using the detections of Apriltags. Each Duckiebots is provided with a plate with an Apriltag. Thus, by tracking the Apriltags on Duckiebots, we could easily track their poses.

Moreover, Since it's Duckie"town". We mean to build our camera system that integrate with the city but not a overhead camera which basically have nothing to do with the infrastructure. Thus, we develop a little tower which is about 60cm in height. At the top of the tower, there's a camera which looks over a part of the city. We called it a "watchtower". The watchtowers are spreaded all over the city, and combine with the field of views of each tower, it is possible to surveillant the whole area.

<figure>
    <p align="center">
      <img style="width:30em" src="images/robotarium.png"/>
    </p>
</figure>

Please keep in mind that the status of the project is still not perfect.

**Keywords**: robotics, megacity, robotarium, auto-localization, localization, apriltag
