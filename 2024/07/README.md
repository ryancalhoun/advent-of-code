# Day 7: Bridge Repair

[Full info here](https://adventofcode.com/2024/day/7)

For this puzzle I did not use any recursion, but also did not
do any pruning. I explored the full set of possible operators
left-to-right without any optimizations to the search space.

For $n$ operators, there are ${k}^{n}$ possibilities to explore.
I use the bits of this number to keep track of which operators.

For part 1, $k = 2$, and for each bit, let 0 represent addition
and 1 represent multiplication. This would work with bit masks
and shifts, however:

For part 2, $k = 3$. So rather than bit masks, I use modulo to
identify the current operation. Addition and multiplication are
the same, but a mod 3 value equal to 2 represents concat.

