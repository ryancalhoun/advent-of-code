# Day 10: Pipe Maze

[Full info here](https://adventofcode.com/2023/day/10)

For this puzzle, I chose to implement the grid as an actual grid. I used an array of
arrays to be indexed by the i, j positions of each spot. Since the grid is so dense,
and since there is a constant need to directly access each spots immediate neighbors,
there is no advantage to attempting an alternate method of storing the data.

For example, it would be possible to store the grid as a single hash, keyed by each
`(i,j)` pair, but there aren't any meaning differences in computational complexity or
code clarity.

The main point here is that my row index `i` goes down as it increases, and column
index `j` goes right as it increases. The concepts of a spot being above, below, left
or right of another spot depend on treating these values consistently.

At each point on the path inside a pipe, the pipe will have two openings. When considering
a spot, I look at the four immediate neighbors, and determine whether the neighbor
and current spot have pipe openings facing each other. I mark each spot visited to avoid
going backwards on the path.

To find the path to the furthest point, I simply find the full path length in one
direction and divide by two.

For part two, I wanted to avoid doing a full grid scan and trying to find a route to
the outside for each spot. Instead, I wanted to take advantage of my knowledge of the
path I already found.

First, I determine the overall direction the path is wound, clockwise or counterclockwise.
This comes from counting left turns vs. right turns along the path. If there are more 
right turns than left (three more, specifically) it is a clockwise loop.
Counterclockwise otherwise.

Knowing this, the enclosed cells are all those to the right of a clockwise path, and
to the left of a counterclockwise path. Here, my own nomenclature is a bit
problematic. I had already called my cardinal directions top, bottom, left, and right.
For this step, however, the `right` of a path could be above, below, left or right
based on the direction you are currently moving. I should have used terms like
north, south, east and west to avoid the ambiguity.

