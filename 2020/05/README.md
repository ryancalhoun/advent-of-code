# Day 5: Binary Boarding

[Full info here](https://adventofcode.com/2020/day/5)

The bulk of this puzzle boils down to reading a binary number from a string.
So each input is broken into two parts, and each part uses a different character
to represent `0` and `1`. That basic level of parsing with a bit-shift operation.

The plane's dimensions (0-127) and (0-7) are the exact limits for a 7-bit and a
3-bit number. So all that's required is to build a single number from the string
of bits and multiply the two results.

For part two, my missing number solution might not work on every input, but knowing
that there is a single missing number, and it isn't the lowest or highest, means
all I need is to find the value `i+1` where `i` is in the sorted list and `i+1`
isn't.
