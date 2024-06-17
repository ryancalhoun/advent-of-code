# Day 13: Knights of the Dinner Table

[Full info here](https://adventofcode.com/2015/day/13)

Languages:
* C# .NET
* Octave

I used .NET's ProcessStartInfo to launch Octave, in order to generate
permutations. To simplify things, I just generated permutations of numbers,
which I used to index into the list of names.

For each permutation, I just had to lookup the effect of the name to the
left and right for each person.
