# Day 2: Cube Conundrum

[Full info here](https://adventofcode.com/2023/day/2)

## Part 1
>As you walk, the Elf shows you a small bag and some cubes which are either red, green, or blue.
>Each time you play this game, he will hide a secret number of cubes of each color in the bag,
>and your goal is to figure out information about the number of cubes.

>To get information, once a bag has been loaded with cubes, the Elf will reach into the bag,
>grab a handful of random cubes, show them to you, and then put them back in the bag.
>He'll do this a few times per game.

>For example, the record of a few games might look like this:
```
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
```
>Determine which games would have been possible if the bag had been loaded with only 12 red cubes,
>13 green cubes, and 14 blue cubes. What is the sum of the IDs of those games?

## Part 2

>The power of a set of cubes is equal to the numbers of red, green, and blue cubes multiplied together.
>The power of the minimum set of cubes in game 1 is 48. In games 2-5 it was 12, 1560, 630, and 36,
>respectively. Adding up these five powers produces the sum 2286.

>For each game, find the minimum set of cubes that must have been present. What is the sum of the
>power of these sets?

---

## Solution

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
