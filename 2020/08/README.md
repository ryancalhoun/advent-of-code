# Day 8: Handheld Halting

[Full info here](https://adventofcode.com/2020/day/8)

For data storage on this puzzle, I kept a list of `(operation, argument)` for each
instruction. To track the program state, I keep a single instruction `ptr` and value `reg`.
Starting with `ptr=0` and `reg=0`, I execute the relevant instruction defined by the operation
name.

This strategy makes it easy to flip `nop` and `jmp` instructions, since I just need
to change each label, then change it back.

Because the program isn't allowed to repeat instructions, a single run is at worst $O(n)$.

Because only a single instruction needs to be flipped, fixing the program so it executes to
the end is at worst $O(n^2)$.
