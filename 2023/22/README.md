# Day 22: Sand Slabs

[Full info here](https://adventofcode.com/2023/day/22)

## Part One

>The Elves responsible for water filtering operations took a snapshot of the
bricks while they were still falling (your puzzle input) which should let you
work out which bricks are safe to disintegrate. For example:
```
1,0,1~1,2,1
0,0,2~2,0,2
0,2,3~2,2,3
0,0,4~0,2,4
2,0,5~2,2,5
0,1,6~2,1,6
1,1,8~1,1,9
```

>Each line of text in the snapshot represents the position of a single brick at
the time the snapshot was taken. The position is given as two x,y,z coordinates
- one for each end of the brick - separated by a tilde (~). Each brick is made
up of a single straight line of cubes, and the Elves were even careful to
choose a time for the snapshot that had all of the free-falling bricks at
integer positions above the ground, so the whole snapshot is aligned to a
three-dimensional cube grid.

>Because the snapshot was taken while the bricks were still falling, some bricks
will still be in the air; you'll need to start by figuring out where they will
end up. Bricks are magically stabilized, so they never rotate, even in weird
situations like where a long horizontal brick is only supported on one end. Two
bricks cannot occupy the same position, so a falling brick will come to rest
upon the first other brick it encounters.

>Your first task is to figure out which bricks are safe to disintegrate. A
brick can be safely disintegrated if, after removing it, no other bricks would
fall further directly downward.

## Part Two

>Disintegrating bricks one at a time isn't going to be fast enough. While it
might sound dangerous, what you really need is a chain reaction.

>You'll need to figure out the best brick to disintegrate. For each brick,
determine how many other bricks would fall if that brick were disintegrated.

>For each brick, determine how many other bricks would fall if that brick were
disintegrated. What is the sum of the number of other bricks that would fall?

---

## Solution

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
