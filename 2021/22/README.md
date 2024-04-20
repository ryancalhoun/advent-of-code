# Day 22: Reactor Reboot

[Full info here](https://adventofcode.com/2021/day/22)

For this puzzle, I store a range as the min and max value, inclusive. I store
each cube as three ranges, one for each dimension. With this I can calculate the
volume of each cube easily, no matter how large the cubes are.

I only store the "on" cubes.

(Back of the napkin math told me I'd need several hundred GB of storage in order to
individually represent each cube in a brute force implementation for part 2, so I
didn't try.)

So, if I only count by adding volumes, I need to avoid counting doubles. So I need
to detect and handle overlapping cubes.

As it turns out, any new cube will obliterate an existing cube that overlaps. If
the new cube is "on", then the new cube's volume will account for those spaces.
If the new cube is "off", then I wouldn't store it anyway. What is left of the
old cube will be the parts the fall outside the bounds of the new one.

So I slice the old cubes, so the parts that are wholly above, below, left, right,
etc, are cut away and re-inserted into the list as new smaller cubes.

Given this structure, it's actually a little bit more difficult to implement part
1, since I now have to correctly ignore cubes outside a region. This part might
not be perfect, since I didn't bother to handle the case of a cube partially in
the region. But, it gets the right answer, so my input data must not have anything
that needed to be handled.
