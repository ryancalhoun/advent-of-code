# Day 10: Monitoring Station

[Full info here](https://adventofcode.com/2019/day/10)

My approach for this puzzle was to trace lines across the grid space for each
possible slope. Along each line, each pair of consecutive asteroids will be able
to see each other. I track these in a list per each asteroid: each asteroid ends
up with a list of its closest visible neighbors. The solution for part one is the
asteroid with the largest list.

For part two, I use `atan2` to convert each point to an angle, and sort by the angle.

