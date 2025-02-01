# Day 6: Guard Gallivant

[Full info here](https://adventofcode.com/2024/day/6)

For this puzzle I kept track of obstacles and visited squares using
maps of points. The guard has a position and a next step.

The next step is a unit vector, e.g. `[0,1]` giving the amount that
will be added to the current position at the next step. This value
is rotated by 90, e.g. `x=-y, y=x`.

For part one, just move until the position is out of bounds.

For part two, at each open location, set then un-set a new obstacle.
While the temporary obstacle is set, clear out visited points and
reset the guard back to position zero. Count detected loops.

Detect a loop by tracking the facing direction (next step unit
vector) at each visited position. If the guard visits the same
spot from a different direction, that does not indicate a loop.
But if the facing direction is the same, that means the current
path has already been visited and must be again.
