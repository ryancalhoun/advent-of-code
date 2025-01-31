# Day 4: Ceres Search

[Full info here](https://adventofcode.com/2024/day/4)

This puzzle gave me a chance to try out Go's interfaces. I made an
interface to receive a sliding window, with one implementation
for part one, and the other for part 2.

For part one, use a 4x4 window. Check each top row and left side.
Check each diagonal. Each match in either direction adds one to the
total.

For part two, a 3x3 window. The center must be an 'A'. The four corners
must be a combination of 'S' and 'M'--two of each. Only count one if
this is true.
