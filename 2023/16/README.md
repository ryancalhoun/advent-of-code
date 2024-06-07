# Day 16: The Floor Will Be Lava

[Full info here](https://adventofcode.com/2023/day/16)

My data structure for this puzzle was very similar to day 14, with the rolling rocks.
I hashed the mirrors and splitters by columns and rows. For each item, in addition to
keeping track of which direction the beam of light should bounce, I also kept a list
of which direction the light comes from--this is important as a stopping condition.

I navigated the beam's path(s) with recursion, though it wasn't necessarily a
recursive solution. Nothing is being permuted or generated through the process, and it
could easily have been done with loops. It would have produced a different visiting
order, but the order is not important.

Each bounce of the beam ends up being independent. There's no need to know where a beam
came from, so there's no need to trace the complete path with all its branches.

The only thing that's important to know is whether a beam has already bounced in the
same direction before, to avoid infinite looping or infinite recursion.

The part two twist was not difficult to accomodate. I just needed to repeat the same
steps all the way around the edges.
