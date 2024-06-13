# Day 3: Perfectly Spherical Houses in a Vacuum

[Full info here](https://adventofcode.com/2015/day/3)

Languages:
* Ruby
* Java

My Java code reads a character at a time from STDIN, and produces a
cooresponding line of `dx dy` movements for each.

My Ruby code launches the Java process, allows it to inherit and consume
STDIN, and pulls the movement info from Java's STDOUT.

Then I just keep track of visited coordinates with a Hash.

I used a little metaprogramming to build an alternating (real/robo) visitor
to consume each direction. So the only difference in code from part 1 to part 2
is that I add a second starting point to the visitor list.
