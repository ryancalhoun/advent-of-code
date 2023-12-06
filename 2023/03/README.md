# Day 3: Gear Ratios

[Full info here](https://adventofcode.com/2023/day/3)

## Part 1
>The engineer explains that an engine part seems to be missing from the engine, but nobody can figure out which one.
>If you can add up all the part numbers in the engine schematic, it should be easy to work out which part is missing.

>Here is an example engine schematic:
```
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..
```
>In this schematic, two numbers are not part numbers because they are not adjacent to a symbol:
>114 (top right) and 58 (middle right).
>Every other number is adjacent to a symbol and so is a part number; their sum is 4361.

>What is the sum of all of the part numbers in the engine schematic?

## Part 2
>The missing part wasn't the only issue -
>one of the gears in the engine is wrong. A gear is any `*` symbol that is adjacent to exactly two part numbers.
>Its gear ratio is the result of multiplying those two numbers together.

>This time, you need to find the gear ratio of every gear and add them all up so that the engineer can figure
>out which gear needs to be replaced.

>In this schematic, there are two gears. The first is in the top left; it has part numbers 467 and 35,
>so its gear ratio is 16345. The second gear is in the lower right; its gear ratio is 451490.

---
## Solution

This puzzle doesn't work as naturally with regexes as most of the others. This one lends itself more to
char-by-char input.

I chose to read line-by-line and char-by-char, and increment `i, j` counters as I went. Consecutive digits
turn into numbers, but it's important to track the location of the number as well as its length. So the value
`664` starts at `9, 1` and ends at `9, 3`. An adjacent symbol could have an `i` value from `8-10` and a `j`
value from `0-4`. It's actually simpler to allow diagonally adjacent values than it would be to rule them
out.

I chose to only store lists of numbers and symbols, not the entire grid. Storing the grid as a whole is
wasteful, especially if the grid is sparse, and iterations to find adjacency involves messy 4-deep nested
loops. Instead, I store each number in a flat list with its `i, j` values, and each symbol in a hash with
all the symbols in row `i` stored in `hash[i]`.

To find adjacent numbers and symbols, assuming _n_ numbers and _m_ symbols, is computationally _O(n*m)_ in
the worst case, where both _n_ and _m_ are significantly smaller than _i_ and _j_. As an optimization, I
only look at symbols stored in `hash[i-1]`, `hash[i]`, and `hash[i+1]`. Doing this brings the amortized
complexity much closer to _O(n*j/m)_.

For part two, while iterating the numbers for the first pass to find adjacent symbols, I link each number
to the symbol. Once this is complete, I make second pass to iterate the symbols to find those that have
exactly two numbers linked.



