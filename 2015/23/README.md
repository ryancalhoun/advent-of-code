# Day 23: Opening the Turing Lock

[Full info here](https://adventofcode.com/2015/day/23)

Languages:
* Bash
* Ruby

For this puzzle, I made a DSL with Ruby that implements the input file's
language. With th DSL loaded, I can execute the input file directly as if
it were its own script.

I added an instruction `output r` that prints the contents of a register.
So to get the final state, I just append the text `output b` to the input
before running it.
