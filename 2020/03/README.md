# Day 3: Toboggan Trajectory

[Full info here](https://adventofcode.com/2020/day/3)

This puzzle can be solved line-by-line. No need to store anything
beyond the position and counter. Because the line repeats forever,
each position is just a modulo on the line length.

Part two is a moderate addition, but one that fits well with what
part one is doing. Instead of a single hard-coded slope, now it is
a list of hard-coded slopes. The slopes are independent, so can
be processed at the same time in any order, the results just 
multiplied at the end.
