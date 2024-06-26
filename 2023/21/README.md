# Day 21: Step Counter

[Full info here](https://adventofcode.com/2023/day/21)

Part one was simple. I struggled with part two (self-inflicted wounds)
until I realized I had forgotten to handle my `-1` sentinel value correctly.

I stored a grid, with rocks (`#`) as nil and everything else as `-1`. I'd fill
the grid from a start point, set to `0`, then step outward and set each value to
one more than the last.

For part one, I just cound all spaces, not nil, even, and 64 or less.

For part two, I sliced the counting up into several parts. The grid repeats
infinitely like a checkerboard. So if all the "black" squares are starting at
zero, the "white" squares would start at 1.

The number of required steps is exactly 65 plus 202300 * 131. So if I go in a
straight line, I'd move 65 to the edge of the tile, then across 202299 complete
tiles (each one alernating "black" and "white") then completely across the final
tile. But, this final tile isn't complete, it's pointy like an arrow.

So after counting up all the complete black and white tiles in the middle, four
pointy corners, and all the edges, the answer is the sum of all that. The angled
edges all insersect tiles in the center (0, 65), (65, 0), etc. So there is one
edge tile with a corner cut off, then another which is just the corner. Keeping
track of which of these tiles should start from 0 or 1 is tricky, but the code
ends up pretty clean in the end.
