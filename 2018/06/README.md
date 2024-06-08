# Day 6: Chronal Coordinates

[Full info here](https://adventofcode.com/2018/day/6)

For this puzzle, I replaced make with cake. I ultimately had to abandon
using STDIN and pass the file by argument, so I'm not completely happy
with that.

Interestingly, part two was much simpler to implemant than part one. I
structured the input data as a list of x,y points. From this list, I can
keep track of the range of x and y values.

For each part, I implement a visitor over the full range of x,y values
that contain the input. There's no need to go outside that range because
any point out there will be part of an infinite area. Only the points inside
this range will matter.

Part one computes the distance to each point and populates a map of `distance->points`.
The smallest distance either has one point, which I count, or more than one and
I ignore it. I keep count of one area per each point, no need to actually store
the grid. But...any closest point to any x,y value along the border gets dropped
because all of that area would be infinite.

Part two just sums the distance from each point to each x,y value.
