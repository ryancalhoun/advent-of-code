# Day 14: Space Stoichiometry

[Full info here](https://adventofcode.com/2019/day/14)

I converted the input data (the reactions) into a map of lists.
That is, a map of result compound, to list of input compounds,
including all the relevant quantities.

I perform a breadth-first traversal, starting with FUEL. For each
whole quantity produced, I keep a running tally of used compounds and
leftovers. Ore is a special case because nothing produces it, so it can
always be consumed in exact quantities.

For part two, I use the ratio of FUEL to Ore to get close to my target.
On each iteration, `fuel = fuel * limit / ore`. Once I get close, I'm
just incrementing and decrementing to fine-tune. This runs in less than
0.5 seconds. A brute-force approach starting from 1 FUEL takes about
2 minutes.
