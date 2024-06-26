# Day 25: Let It Snow

[Full info here](https://adventofcode.com/2015/day/25)

Languages:
* Java
* Perl

I used the Triangular number formula in Java to identify the position in the
sequence that corresponds to the given row and column.

All the positions along row 1 are triangular numbers, so the number at the top
of each column $c$ is:

$$ n = \frac{ c \cdot (c-1) }{ 2 } $$

Each value below that column is another triangular progression, but starting
from the column value. So, from column 3: add 3, then 4, then 5, then 6. From
column 99, add 99, then 100, then 101.

Once I have the sequence position, I pipe it to Perl where I just multiply my
way up to the correct code.
