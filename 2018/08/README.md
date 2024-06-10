# Day 8: Memory Maneuver

[Full info here](https://adventofcode.com/2018/day/8)

I decided to implement this solution with a stack instead of recursion.
To represent each tree node, I created a Node class, to hold the header
information on the way down the stack, and the value information on the
way back up.

The nodes aren't linked, and get thrown away once we've moved past them
in the input stream.

I wrap each node in a Frame class, which adds an index to keep track of
which child we are working on next.

The difference between parts one and two all comes down to how the value
of the node is calculated, and that can be generalized with a dotnet
Func delegate.
