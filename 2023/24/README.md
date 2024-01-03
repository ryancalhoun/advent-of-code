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

_Part Two:_

Wow this was more difficult than I was expecting. Even after
realizing that I'd need to solve a system of equations to find multiple
unknowns, I wasn't sure of the best method of defining the unknowns.

After lots and lots of pages of scratch paper and looking up old formulas, 
here goes.

My goal is to get something in the form $ax + by + cz = d$, so that I can
use an $LU$ solver to get the answer.

The unknowns are $x_{0}, y_{0}, z_{0}, vx, vy, vz$. But these are not all
independent unknowns. Because there is a single magic line that intersects
all others, this problem should be unambiguously solvable in the $xy$ plane,
so I'm going to ignore the $z$ direction.

Now, each hail stone $i$ has motion vectors:

$$
\begin{aligned}
x_{i} & = x_{i_{0}} + t\cdot vx_{i} \\
y_{i} & = y_{i_{0}} + t\cdot vy_{i}
\end{aligned}
$$

These vectors are equal to those of our unknown magic stone at time $t_{i}$:

$$
\begin{aligned}
x_{0} + t_{i}\cdot vx & = x_{i_{0}} + t_{i}\cdot vx_{i} \\
y_{0} + t_{i}\cdot vy & = y_{i_{0}} + t_{i}\cdot vy_{i}
\end{aligned}
$$

Rearrange these in terms of $t_{i}$:

$$
\begin{aligned}
t_{i} & = \frac{x_{i_{0}} - x_{0}}{vx - vx_{i}} \\
t_{i} & = \frac{y_{i_{0}} - y_{0}}{vy - vy_{i}}
\end{aligned}
$$

We don't actually need $t_{i}$ yet--we'll find it later. For now, it's enough to
know that the desired intersection occurs at the same $t$ value for both $x$ and $y$:

$$
\frac{x_{i_{0}} - x_{0}}{vx - vx_{i}} = \frac{y_{i_{0}} - y_{0}}{vy - vy_{i}}
$$

Cross-multiply:

$$
\begin{aligned}
(x_{i_{0}} - x_{0})(vy - vy_{i}) & = (y_{i_{0}} - y_{0})(vx - vx_{i}) \\
x_{i_{0}}\cdot vy - x_{i_{0}}\cdot vy_{i} - x_{0}\cdot vy + x_{0}\cdot vy_{i}
  & = y_{i_{0}}\cdot vx - y_{i_{0}}\cdot vx_{i} - y_{0}\cdot vx + y_{0}\cdot vx_{i}
\end{aligned}
$$

And the immediate problem is we have terms which are the product of two unknowns like $x_{0}\cdot vy$.
Fortunately, all these terms are independent of $i$, and can be removed through subtraction.

For this step, define

$$
\begin{aligned}
f(i) & = x_{i_{0}}\cdot vy - x_{i_{0}}\cdot vy_{i} - x_{0}\cdot vy + x_{0}\cdot vy_{i} \\
g(i) & = y_{i_{0}}\cdot vx - y_{i_{0}}\cdot vx_{i} - y_{0}\cdot vx + y_{0}\cdot vx_{i}
\end{aligned}
$$

So if $f(i) = g(i)$ and $f(j) = g(j)$, then $f(i) - f(j) = g(i) - g(j)$.

$$
\begin{aligned}
f(i) - f(j) & = x_{i_{0}}\cdot vy - x_{i_{0}}\cdot vy_{i} - \cancel{x_{0}\cdot vy} + x_{0}\cdot vy_{i} -
                x_{j_{0}}\cdot vy + x_{j_{0}}\cdot vy_{j} + \cancel{x_{0}\cdot vy} - x_{0}\cdot vy_{j} \\
g(i) - g(j) & = y_{i_{0}}\cdot vx - y_{i_{0}}\cdot vx_{i} - \cancel{y_{0}\cdot vx} + y_{0}\cdot vx_{i} -
                y_{j_{0}}\cdot vx + y_{j_{0}}\cdot vx_{j} + \cancel{y_{0}\cdot vx} - y_{0}\cdot vx_{j}
\end{aligned}
$$

And finally with those products of unknowns canceled, the remaining terms can be rearranged to group
knowns and unknowns together.

$$
x_{0}(vy_{i} - vy_{j}) + y_{0}(vx_{j} - vx_{i}) + vx(y_{j_{0}} - y_{i_{0}}) + vy(x_{i_{0}} - x_{j_{0}})
  = x_{i_{0}}\cdot vy_{i} - y_{i_{0}}\cdot vx_{i} - x_{j_{0}}\cdot vy_{j} + y_{j_{0}}\cdot vx_{j} 
$$

With four unknowns, I need a system of four equations. That is, four pairs of differences between stones
$i$ and $j$. 

I set up a $4\times{4}$ matrix of coefficients $A$, and a 4-element RHS vector $b$, such that $A\cdot x = b$, and
solve using Ruby's built-in LU solver. I've coded all these numerical recipies previously in C, so I
feel no need to roll my own decomposition or elimination routines again.

Once I have the $xy$ values, it is pretty simple to find the $z$ values. I need another pair of stones
so that I can identify the $\partial{t}$ and $\partial{z}$ changes between those two collisions.

$$
\begin{aligned}
t_{1} & = \frac{ x_{1} - x_{0} } { vx - vx_{1} } \\
t_{2} & = \frac{ x_{2} - x_{0} } { vx - vx_{2} } \\
\partial{t} & = t_{2} - t_{1} \\
\partial{z} & = ( z_{2} + t_{2}\cdot vz_{2} ) - ( z_{1} + t_{1}\cdot vz_{1} ) \\
vz & = \frac{\partial{z}}{\partial{t}} \\
z_{0} & = ( z_{1} + t_{1}\cdot vz_{1} ) - t_{1}\cdot vz
\end{aligned}
$$

Wow, time to step back and take a deep breath. I'm glad these puzzles aren't all this involved.



