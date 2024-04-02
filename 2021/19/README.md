# Day 19: Beacon Scanner

[Full info here](https://adventofcode.com/2021/day/19)

This puzzle took a while to complete. I spent several iterations making optimizations
to get the run time first down to a very slow two minutes, then to 20 seconds, then
to 2 seconds.

I store each sensor with its list of beacons. First, all the sensors are in an unknown
list. Sensor #0 moves to the known list, because all others will be relative to it.

Then, one by one I remove sensors from the unknown list, align them with sensor #0, and
move them to the known list. Each time known list grows, there are more options to find
a match for one of the unknowns.

The rotations required to get each possible facing follow a sequence of clockwise,
counter-clockwise, and forward rotations. The sequence goes like this:

* CW
* CW
* CW
* Forward
* CCW
* CCW
* CCW
* Forward
* CW
* CW
* CW
* Forward
* CCW
* CCW
* CCW
* Forward
* CW
* CW
* CW
* Forward
* CCW
* CCW
* CCW
* Forward

The last rotation brings everything back to its original facing, so if there are no matches
on this attempt, it is ready to go for a future attempt.

All the known sensors are all oriented in a single direction. Each unknown sensor must go 
through this series of rotations and be compared with all of the known sensors.

When there are no more unknown, the hard part is over.

The actual answers for parts one and two are both trivial once all the sensors are aligned.





