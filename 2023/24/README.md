# Day 24: Never Tell Me The Odds

[Full info here](https://adventofcode.com/2023/day/24)

## Part One

>Due to strong, probably-magical winds, the hailstones are all flying through
the air in perfectly linear trajectories. You make a note of each hailstone's
position and velocity (your puzzle input). For example:
```
19, 13, 30 @ -2,  1, -2
18, 19, 22 @ -1, -1, -2
20, 25, 34 @ -2, -2, -4
12, 31, 28 @ -1, -2, -1
20, 19, 15 @  1, -5, -3
```
>Each line of text corresponds to the position and velocity of a single
hailstone. The positions indicate where the hailstones are right now (at time
0). The velocities are constant and indicate exactly how far each hailstone
will move in one nanosecond.

>To estimate this, consider only the X and Y axes; ignore the Z axis. Looking
forward in time, how many of the hailstones' paths will intersect within a test
area? (The hailstones themselves don't have to collide, just test for
intersections between the paths they will trace.)

>In this example, look for intersections that happen with an X and Y position
each at least 7 and at most 27; in your actual data, you'll need to check a
much larger test area.

>Look for intersections that happen with an X and Y position each at least
200000000000000 and at most 400000000000000. Disregard the Z axis entirely.

>Considering only the X and Y axes, check all pairs of hailstones' future paths
for intersections. How many of these intersections occur within the test area?

## Part Two

>Upon further analysis, it doesn't seem like any hailstones will naturally
collide. It's up to you to fix that!

>You find a rock on the ground nearby. While it seems extremely unlikely, if you
throw it just right, you should be able to hit every hailstone in a single
throw!

>Determine the exact position and velocity the rock needs to have at time 0 so
that it perfectly collides with every hailstone. What do you get if you add up
the X, Y, and Z coordinates of that initial position?

---

## Solution

Part one is a linear equation solver in two dimensions. For each stone, I take
the position and velocity, and find the line's slope and y-intercept. It's
also necessary to know the direction of motion, to determine if an intersection
point is in the future or past.

Given initial position `x`, `y`, and constant velocity `vx` and `vy`:

$$
\begin{aligned}
m & = vy / vx \\
b & = y - mx
\end{aligned}
$$

Then the intersection point between two stones _with different slopes_ is:

$$
\begin{aligned}
x & = \frac{b_{1} - b_{0}}{m_{0} - m_{1}} \\
y & = \frac{m_{0}b_{1} - m_{1}b_{0}}{m_{0} - m_{1}}
\end{aligned}
$$

This point must be checked if it occurs in the future or past. In other
words, does the new point `x`, `y` occur in the same direction as `vx`, `vy`
from the original point? This must be true for both stones.

I haven't yet attempted part two.
