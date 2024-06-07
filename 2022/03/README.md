# Day 3: Rucksack Reorganization

[Full info here](https://adventofcode.com/2022/day/3)

This puzzle comes down to finding set intersections between various groups
of keys.

I don't actually store the item code anywhere, because it isn't needed for
anything. I just convert it straight away to the priority, and make all the
comparisons that way.

For part one, each line is a group, and each set is half the line.

For part two, every three lines is a group, and each set is the whole line.

Python generators help with the code organization quite a bit.


