# Day 22: Wizard Simulator 20XX

[Full info here](https://adventofcode.com/2015/day/22)

Languages:
* Ruby
* Assembly

This one is kinda slow. It's a recursive depth-first search, but cut off
paths for which the cost exceeds an already identified minimum cost.

Each spell is implemented in Assembly, and built as a shared library. The
Ruby wizard loads a spellbook from all shared libraries and creates a spell
class for each one.
