# Day 13: Claw Contraption

[Full info here](https://adventofcode.com/2024/day/13)

This puzzle required some cleverness. The description is worded
to sound like an optimization problem, e.g. "find the minimum".

Really, it is a system of linear equations with two unknowns.

They all have a solution; however, we are only looking for those
with integer solutions. Positive integers at that.

The equation pair looks like this:

$$
\begin{aligned}
A_{x}\cdot a + B_{x}\cdot b & = P_{x} \\
A_{y}\cdot a + B_{y}\cdot b & = P_{y}
\end{aligned}
$$

After some deriving:

$$
\begin{aligned}
b & = \frac{P_{y}A_{x} - P_{x}A_{y}}{A_{x}B_{y} - A_{y}B_{x}} \\
a & = \frac{P_{x} - B_{x}\cdot b}{A_{x}}
\end{aligned}
$$

Then check whether those (integer) values for $a$ and $b$ are correct
by plugging them back into both original equations.
