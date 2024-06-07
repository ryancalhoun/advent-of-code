# Day 22: Sand Slabs

[Full info here](https://adventofcode.com/2023/day/22)

The initial step was pretty simple, just determine if two bricks overlap. They
need at least one square of overlap in both `x` and `y` directions.

The first challenge was figuring out how to treat the bricks as they stacked.
I sorted them by their `z` minimum, so the lowest part of the lowest brick 
would hit the ground first. My assumption was that bricks would not be
overlapped in their initial positions, so I could safely handle one brick at
a time. The trick is that some bricks are different heights, so one may rest
at a lower level but the top may be at a higher level than its neighbor.

Because the `x`, `y` space was only 10x10, I just stored each spot of the
"floor" to be the topmost point of each brick at that spot. It starts as all
zeros and gets higher with each brick. So the resting point of each falling
brick will be the max value of each `x`, `y` space it will occupy. That max
is the tallest brick that has already fallen below it.

As I settled the bricks, I also recorded hashes of each brick--which bricks
is it supporting, and which bricks is it supported by. Given only one, I
could reconstruct the other, but it would have been an expensive and
unnecessary traversal.

Counting safe bricks for part one was simple.

Counting chain reactions for part two was more involved. It was a traversal
of supported bricks from the bottom up; however, I needed to do the traversal
whole levels at a time instead of a brick at a time. So, for each set of
bricks supported by "those" bricks beneath, find the set of bricks above
supported only by "these". If I remove "A" at the bottom level and above it
are "B" and "C", I need to check all bricks that are supported by either "B"
or "C" or both, but by nothing else.
