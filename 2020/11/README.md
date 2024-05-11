# Day 11: Seating System

[Full info here](https://adventofcode.com/2020/day/11)

For this puzzle, I stored a list of seats, each with a list of references
to neighboring seats.

I make an initial iteration of the grid layout, in order to find and link
neighbors. All subsequent iterations only look these prepopulated lists
and don't require any information about the grid.

For part one, I look only at immediate neighbors. For part two, some more
complex iteration to look outward in each direction, but ending with the
same result.

To make the updates, I use the following convention:

* A value < 0 is empty
* A value > 0 is filled
* A value of -2 is empty but will be filled
* A value of +2 is filled but will be empty

This approach does require an extra pass to update all the values, but
doesn't require any additional storage.
