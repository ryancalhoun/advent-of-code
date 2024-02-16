# Day 14: Extended Polymerization

[Full info here](https://adventofcode.com/2021/day/14)

It took me a bit to get part two working. My part one implementation using
queues to perform the insertions didn't scale, and I had to switch from actually
producing the full string to simply counting the pairs.

Any pair within the string will produce the same result, no matter where it is or
how many times it occurs. So for each pair, replace it with the same number of pairs
like so:

* If I have 2 `AB` pairs, and a rule `AB -> C`
* The result should be 2 `AC` and 2 `CB` pairs.

The final pair count will contain the invididual character counts. Either sum the
counts for the first member of each pair, plus one for the original last character.
Or, sum the counts for the second member of each pair, plus one for the original
first character. Both methods lead to the same results.

Using the sample string `NNCB` and sample rules, after two steps, I'd have 
`NBCCNBBBCBHCB` and would have counted the following pairs:

* BB: 2
* BC: 2
* BH: 1
* CB: 2
* CC: 1
* CN: 1
* HC: 1
* NB: 2

If I add up the totals for each pair's ending letter (`C` for `BC and `H` for `BH`, etc)
I'd get:

* B: 6
* C: 4
* H: 1
* N: 1

Everything is right except `N`, because I need to add one to the original first
letter. That gives a total of 2 `N`'s. Then the rest is just finding the min and max.
