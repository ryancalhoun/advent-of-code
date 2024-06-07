# Day 1: Trebuchet?!

[Full info here](https://adventofcode.com/2023/day/1)

The parsing of the part one document is pretty straightforward using regexes. It's just matching single digits
using `/\d+/` and ignoring everything else.

The wrinkle in part two is two-fold. First, you obviously have to match the spelled-out digits as well. And
second, you have to account for overlapping words like `oneight` or `sevenine`. With regexes, this can be done
with a look-ahead match, such as `/(?=(\d|...))/`, which can find a match on the input without consuming the input.
