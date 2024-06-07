# Day 5: Alchemical Reduction

[Full info here](https://adventofcode.com/2018/day/5)

This solution was pretty compact using .NET query methods. I define a
single function to get the "reacted" length.

For part two, I find the "minimum" of the possible characters, when
removing each and re-calling the react function on each possibility.
