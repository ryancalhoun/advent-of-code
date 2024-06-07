# Day 11: Cosmic Expansion

[Full info here](https://adventofcode.com/2023/day/11)

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



