# Day 9: Disk Fragmenter

[Full info here](https://adventofcode.com/2024/day/9)

This gets messy with bunches of indexes going all over the place.

I created a list containing the full set of disk blocks. I used
-1 for free space.

Neither part had a trick. Just iterate, find start and end indexes,
copy numbers. Straightforward but messy.
