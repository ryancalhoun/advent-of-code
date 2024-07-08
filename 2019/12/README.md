# Day 12: The N-Body Problem

[Full info here](https://adventofcode.com/2019/day/12)

For the moons, I store a 3-array for position and for velocity. The velocity
is updated for each pair of moons, and the position just once per step.

For part two, I find the period independently for each moon, for each coordinate.
The x, y, and z values cycle at different rates, and the period for the moon
as a whole must be the LCM of those three.

The period of the system as a whole is the LCM of the four moons together. The
data type has to be `long` to avoid overflow, and the calculation needs a couple
shortcuts to avoid repeating very large loops.
