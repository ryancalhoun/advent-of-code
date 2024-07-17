# Day 15: Oxygen System

[Full info here](https://adventofcode.com/2019/day/15)

I went for a simple data structure this time, just a 2-d array of
integers.

I used a recursive backtracking search pattern with the droid, and
filled in values of `0` for unknown, `-1` for wall and `-2` for open.

I didn't worry about finding an optimal path length. After experimenting
with the data it appeared to be a maze with only one correct path. The path
length was just the number of steps it took to unwind the backtracking.

Once I had the location of the oxygen, I used a recursive flood-fill
for all the open values, counting the distance from the source. As I went
I filled in the array, replacing all the `-2` values with positive distance.
The end result was the max of these values.

