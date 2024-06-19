# Day 16: Aunt Sue

[Full info here](https://adventofcode.com/2015/day/16)

Languages:
* Bash (sed/awk)
* Ruby

The main Bash script reads all the data and mangles it into an embedded
Ruby script. Comparisons for each key are written out as named methods, and in
part 2 selected methods operator `==` are overwritten.

The Ruby script simply iterates a list of JSON objects and calls the method named
by each key.
