# Day 1: Not Quite Lisp

[Full info here](https://adventofcode.com/2015/day/1)

Languages:
* Bash/Awk/Sed/Grep
* Perl

I split the input sequence and transformed into numbers with sed. I fed
the sequence into an embedded perl script that output the current instruction
and current floor for each symbol.

Part 1's result was the last line. Part 2's result was the first line with a
negative value.
