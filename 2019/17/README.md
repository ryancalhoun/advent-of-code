# Day 17: Set and Forget

[Full info here](https://adventofcode.com/2019/day/17)

For part one, on each line I looked for the pattern `###` immediately
below a `.#.`. Since each intersection was a clean and distinct, not 
directly adjacent to another or an edge, this approach worked.

For part two, the pattern of left/right turns was not too complex, so
I simply counted and split it apart by hand. The specifics of my path
only work for my input. I was not prepared to spend the time it would
take to generalize the solution further.
