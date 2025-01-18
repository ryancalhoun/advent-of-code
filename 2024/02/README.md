# Day 2: Red-Nosed Reports

[Full info here](https://adventofcode.com/2024/day/2)

Go is weird, and I'm still getting used to the ways the built-in types work
(or don't work).

Part one was just computing the diffs between consecutive array elements. Either
all the diffs are 1, 2, or 3; or -1, -2, -3.

Part two probably has a clever solution just based on modifying the list of
diffs. For example, if I see 1, 4, -1, I could add the 4 and -1 together to get
1, 3.

I just went with the simpler brute force approach of dropping one value at a 
time from the value lists.
