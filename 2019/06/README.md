# Day 6: Universal Orbit Map

[Full info here](https://adventofcode.com/2019/day/6)

I stored the planets as a map of planet name to list of children. This
makes it easy to count the total depths, by performing a breadth-first
traversal.

Such a structure doesn't work as well for part two, where I needed to
invert the map into child-parent. Going in this direction, there is no
need for a list since each child has exactly one parent. To count, I
just follow the path from each leaf to the root. Any nodes I visited
twice are not part of the path. The answer is the sum of nodes only
visted once. 
