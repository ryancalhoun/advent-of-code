# Day 17: Conway Cubes

[Full info here](https://adventofcode.com/2020/day/17)

This puzzle was fun. Interestingly, a limitation of the way Perl passes arguments
as lists made the part two twist rather simple to implement.

First, for structure. I kept a single hash of all active cubes. Since Perl doesn't
hash lists, I used `"x,y,z"` as the key for each cube. I don't need to keep track
of inactive cubes, since only neighbors of active cubes will ever be under
consideration.

For each cycle, I iterate all my cubes, and add 1 to each of that cube's neighbors.
At the conclusion of this, I have a hash that contains the count of all active
neighbors for each cube--and this will include currently inactive cubes as well as
active.

So because I am using `split` and `join` to change keys to coordinates and back,
I just pass the split coords as a list rather than calling out the x, y, z values.

The only place I needed to make an update was to change my nested 3D loops to find
all neighbors into an N-D recursive call. Then for part two, just add an extra 0 to
the end of the coordinate for each cube.
