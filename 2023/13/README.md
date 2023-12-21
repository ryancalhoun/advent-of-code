# Day 13: Point of Incidence

[Full info here](https://adventofcode.com/2023/day/13)

## Part 1

>You note down the patterns of ash (.) and rocks (#) that you see as you walk
(your puzzle input); perhaps by carefully analyzing these patterns, you can
figure out where the mirrors are!

>For example:
```
#.##..##.
..#.##.#.
##......#
##......#
..#.##.#.
..##..##.
#.#.##.#.

#...##..#
#....#..#
..##..###
#####.##.
#####.##.
..##..###
#....#..#
```

>To find the reflection in each pattern, you need to find a perfect reflection
across either a horizontal line between two rows or across a vertical line
between two columns.

## Part 2

>Upon closer inspection, you discover that every mirror has exactly one smudge:
exactly one . or # should be the opposite type.

>In each pattern, you'll need to locate and fix the smudge that causes a
different reflection line to be valid. (The old reflection line won't
necessarily continue being valid after the smudge is fixed.)

>In each pattern, fix the smudge and find the different line of reflection.
What number do you get after summarizing the new reflection line in each
pattern in your notes?

---

## Solution

To avoid the storage and computation costs of dealing with a full grid, I
decided to reduce each row and colum to a single integer for comparison.
The grid contains only two values, so it is straightforward to treat each
row and column as a sequence of binary digits.

To find a reflection in a list of integers, I start by grouping indexes by
their scores. So in a row, if values at 1 and 6 are equal, the indexes
1 and 6 go in the same bucket.

A few rules;

* A reflection line must have consecutive indexes.
* One end of the list or the other must be part of the reflection.
* Index pairs are always separated by an even number.
* All index pairs in a reflection will add to the same value, e.g. 1 & 6, 2 & 5, 3 & 4.

For part two, my decision not to store each element of the grid caused a
wrinkle. I had to use log2 to identify which positions made up the original
value in order to toggle them.

Any item that is a potential match must differ by exactly a power of 2.

With the list of candidate pairs identified, it's just a matter of iterating
the possibilities.


