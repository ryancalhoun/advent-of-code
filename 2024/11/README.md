# Day 11: Plutonian Pebbles

[Full info here](https://adventofcode.com/2024/day/11)

For this puzzle I used recursion to implement the rules for each
blink. The depth of recursion is the number of blinks. For part one
25, for part two 75.

To get part two to run, I added memoization for each possible set of
stone value to blink number. Without this memoization it takes forever.
With it, the runtime is basically zero.
