# Day 9: Smoke Basin

[Full info here](https://adventofcode.com/2021/day/9)

The nuts and bolts of this solution was 2D neighbor check, and a 2D flood-fill
stopping at 9s.

I went back and forth on how to represent the actions for each part, and I think
I came away with a fairly decent pattern. I used a templated member function, with
the templated type being either add up the risks, or multiply the basin sizes.
This allowed a decent separation of concerns without cluttering up the main too
much with boilerplate.

For the cave, I made a low-point iterator. This finds all the low points within
the cave for part one, and has the advantage of a good starting point for the
basins in part two.

I also took the opportunity to enrich my makefiles with header dependencies.
