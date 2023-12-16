# Day 16: The Floor Will Be Lava

[Full info here](https://adventofcode.com/2023/day/16)

## Part One

>Upon closer inspection, the contraption appears to be a flat, two-dimensional
square grid containing empty space (.), mirrors (/ and \\), and splitters (| and
-).

>The contraption is aligned so that most of the beam bounces around the grid,
but each tile on the grid converts some of the beam's light into heat to melt
the rock in the cavern.

>You note the layout of the contraption (your puzzle input). For example:
```
.|...\....
|.-.\.....
.....|-...
........|.
..........
.........\
..../.\\..
.-.-/..|..
.|....-|.\
..//.|....
```

>- If the beam encounters empty space (.), it continues in the same direction.
>- If the beam encounters a mirror (/ or \\), the beam is reflected 90 degrees depending on the angle of the mirror. For instance, a rightward-moving beam that encounters a / mirror would continue upward in the mirror's column, while a rightward-moving beam that encounters a \ mirror would continue downward from the mirror's column.
>- If the beam encounters the pointy end of a splitter (| or -), the beam passes through the splitter as if the splitter were empty space. For instance, a rightward-moving beam that encounters a - splitter would continue in the same direction.
>- If the beam encounters the flat side of a splitter (| or -), the beam is split into two beams going in each of the two directions the splitter's pointy ends are pointing. For instance, a rightward-moving beam that encounters a | splitter would split into two beams: one that continues upward from the splitter's column and one that continues downward from the splitter's column.

>The light isn't energizing enough tiles to produce lava; to debug the
contraption, you need to start by analyzing the current situation. With the
beam starting in the top-left heading right, how many tiles end up being
energized?

## Part Two

>There, a collection of buttons lets you align the contraption so that the beam
enters from any edge tile and heading away from that edge. (You can choose
either of two directions for the beam if it starts on a corner; for instance,
if the beam starts in the bottom-right corner, it can start heading either left
or upward.)

>Find the initial beam configuration that energizes the largest number of tiles;
how many tiles are energized in that configuration?

---

## Solution

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
