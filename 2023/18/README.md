# Day 18: Lavaduct Lagoon

[Full info here](https://adventofcode.com/2023/day/18)

## Part 1

>Elves have already started creating a large lagoon nearby for this purpose.

>However, they aren't sure the lagoon will be big enough; they've asked you to
take a look at the dig plan (your puzzle input). For example:
```
R 6 (#70c710)
D 5 (#0dc571)
L 2 (#5713f0)
D 2 (#d2c081)
R 2 (#59c680)
D 2 (#411b91)
L 5 (#8ceee2)
U 2 (#caa173)
L 1 (#1b58a2)
U 2 (#caa171)
R 2 (#7807d2)
U 3 (#a77fa3)
L 2 (#015232)
U 2 (#7a21e3)
```
>The digger starts in a 1 meter cube hole in the ground. They then dig the
specified number of meters up (U), down (D), left (L), or right (R), clearing
full 1 meter cubes as they go. The directions are given as seen from above, so
if "up" were north, then "right" would be east, and so on. Each trench is also
listed with the color that the edge of the trench should be painted as an RGB
hexadecimal color code.

>When viewed from above, the above example dig plan would result in the
following loop of trench (#) having been dug out from otherwise ground-level
terrain (.): ``` ####### #.....# ###...# ..#...# ..#...# ###.### #...#..
##..### .#....# .###### ```

>At this point, the trench could contain 38 cubic meters of lava. However, this
is just the edge of the lagoon; the next step is to dig out the interior so
that it is one meter deep as well:
```
#######
#######
#######
..#####
..#####
#######
#####..
#######
.######
.######

>The Elves are concerned the lagoon won't be large enough; if they follow their
dig plan, how many cubic meters of lava could it hold?

## Part 2

>After a few minutes, someone realizes what happened; someone swapped the color
and instruction parameters when producing the dig plan. They don't have time to
fix the bug; one of them asks if you can extract the correct instructions from
the hexadecimal codes.

>Each hexadecimal code is six hexadecimal digits long. The first five
hexadecimal digits encode the distance in meters as a five-digit hexadecimal
number. The last hexadecimal digit encodes the direction to dig: 0 means R, 1
means D, 2 means L, and 3 means U.

>So, in the above example, the hexadecimal codes can be converted into the true
instructions:
```
#70c710 = R 461937
#0dc571 = D 56407
#5713f0 = R 356671
#d2c081 = D 863240
#59c680 = R 367720
#411b91 = D 266681
#8ceee2 = L 577262
#caa173 = U 829975
#1b58a2 = L 112010
#caa171 = D 829975
#7807d2 = L 491645
#a77fa3 = U 686074
#015232 = L 5411
#7a21e3 = U 500254
```
>Digging out this loop and its interior produces a lagoon that can hold an
impressive 952408144115 cubic meters of lava.

---

## Solution

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

