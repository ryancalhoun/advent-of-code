# Day 23: Amphipod

[Full info here](https://adventofcode.com/2021/day/23)

For part one, I constructed a burrow as a fixed list of amphipods,
each tracking a position (horizontal) and a depth. This tells me if
they are in a room or in the hallway. I did a brute-force recusive
search of all possible ways to get them sorted.

It got the right answer but was slow. I have a feeling it won't scale
for part two, and I'll need to refine my technique.
