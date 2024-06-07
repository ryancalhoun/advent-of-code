# Day 18: Lavaduct Lagoon

[Full info here](https://adventofcode.com/2023/day/18)

I initially implemented part one by storing the exterior coordinates in a hash.
That is, one hash key per each dig step, so a trench 4 meters long results in
four hash keys. This was significantly less to store than a sparse array-based
matrix.

But, then I did a flood-fill to count the interior.

I was thinking that I could modify the flood fill to only store the filled
neighbors and drop the rest, to avoid storing too much.

I was not anticipating just how much of a scale increase part two would actually
have. My initial solution could not even make it through building the perimeter
before running out of memory.

So instead of storing all the perimeter coordinates, I only stored the begin and
end. And from this, I can tell which trenches go up, down, left, and right.

Assuming the perimeter went clockwise, I need to scan across from each up-going
trench to find down-going trenches to th right. Each area of overlap is just a
basic rectangle. The main trick is making sure all the interior rectangles are
lined up against each other so that all rows are counted exactly once.

With this solution, the dimensions don't matter at all, only the number of 
turns made.

