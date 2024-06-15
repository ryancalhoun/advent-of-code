# Day 9: All in a Single Night

[Full info here](https://adventofcode.com/2015/day/9)

Languages:
* Ruby
* Perl

The Ruby and Perl interpreters each run the same source code. The app
starts in Ruby from the shebang. It exec's Perl to take over and read the
input file, and built the graph.

I used a hash of hashes to store the graph edges.

Once I have the list of cities, I run Ruby again to produce a list of all
permutations of city names, and read each result back.

The Perl code looks up each city order in the graph to verify all the edges
connect.
