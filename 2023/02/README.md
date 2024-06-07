# Day 2: Cube Conundrum

[Full info here](https://adventofcode.com/2023/day/2)

The crux of part one is to filter out lines (games) where any number-color pair exceeds the stated
max values of 12, 13, and 14 cubes. This can actually be done without any data structures, by simply
comparing the numbers while reading. Said, another way, it makes no difference if `20 red` appears
in the first throw or last throw, since either way the whole game gets skipped.

I chose to implement by storing each game in a hash and compute "possible" vs "impossible" games
to mirror the way the problem was described, which actually made part two easier.

For part two, rather than filtering games, the goal is to find the max value of each color for each
game. Technically the grouping of cubes and throws with `,` and `;` still doesn't matter, since `20 red`
going to be the max regardless where it appears. But, this does require storage to track the max value
for each color before multiplying.
