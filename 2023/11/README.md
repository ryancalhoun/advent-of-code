# Day 11: Cosmic Expansion

[Full info here](https://adventofcode.com/2023/day/11)

## Part 1

>The researcher has collected a bunch of data and compiled the data into a
single giant image (your puzzle input). The image includes empty space (.) and
galaxies (#). For example:
```
...#......
.......#..
#.........
..........
......#...
.#........
.........#
..........
.......#..
#...#.....
```

>The researcher is trying to figure out the sum of the lengths of the shortest
path between every pair of galaxies. However, there's a catch: the universe
expanded in the time it took the light from those galaxies to reach the
observatory.

>Due to something involving gravitational effects, only some space expands. In
fact, the result is that any rows or columns that contain no galaxies should
all actually be twice as big.

>Expand the universe, then find the length of the shortest path between every
pair of galaxies. What is the sum of these lengths?

## Part 2

>The galaxies are much older (and thus much farther apart) than the researcher
initially estimated.

>Now, instead of the expansion you did before, make each empty row or column one
million times larger. That is, each empty row should be replaced with 1000000
empty rows, and each empty column should be replaced with 1000000 empty
columns.

---

## Solution

I did not store my galaxies on a grid. Right from the beginning, it looked too
sparse for that to be practical. There is never a need to iterate all the points
in space; but there is a need to iterate all the pairs of galaxies.

Instead, I simply stored the list of galaxies only, with their positional coordinates.

With this type of structure, I can simulate a row-by-row or column-by-column
traversal if necessary, by sorting the list by either `i` or `j`.  What I'm
interested in is the increment between each galaxy and the last. A step of 0 means
multiple galaxies are in the same row or column. A step of 1 means I'm looking at an
adjacent row or column, and no expansion is needed. A step of 2 or more indicates
empty rows or columns that need to be expanded.

Expanding the universe is done by keeping a running value to be added to all
following galaxies. If I shift down row 2, I have to equally shift down all rows
below it.

This approach required exactly two traversals through the list of galaxies, sorted
each direction. Then, a `O(n^2)` traversal through the same list to visit each
pair. This complexity is independent of the size of the universe.

Because of the way I'd written part one, accomplishing part two was extremely 
simple. I just needed to realize that I was already implicitly adding the running
value multiplied by `(rate-1)` where rate was `2`. Then was able to multiply by
`(1,000,000-1)`, and the solution worked with no other changes.



