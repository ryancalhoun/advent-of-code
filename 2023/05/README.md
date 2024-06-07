# Day 5: If You Give A Seed A Fertilizer

[Full info here](https://adventofcode.com/2023/day/5)

On its face, this puzzle is just an iterative map lookup. Take an input, look up its value in
the first map, then use that as input to the next map, and so on.

The naive solution is to pre-compute all the possible values for each map, and lookups are simple.
However, that becomes computationally prohibitive on the much larger full input, where many of 
the ranges span hundreds of millions.

It is better to store the range information, and compute the actual value as part of the lookup.
The data structures needed become more complex, but results in negiligible memory and compute
requirements.

For part two, the input set grows from twenty values to billions. A brute-force approach here is
not feasible.

One possibility is to search backwards through the maps, starting with location values. In theory,
starting at the smallest location and working up should allow stopping much sooner. But in practice,
this is still a brute-force approach that has a short circuit in the logic. Think: _many hours_ instead
of _many-many hours_.

I settled on implementing range lookup instead of trying to lookup each value within a range. At each
level, a particular source range may be all or partly mapped to a destination range. For example if I've
mapped `10-15` to `20-25` and I try to lookup `5-15`, I should get two destination ranges as a result:
`5-9` and `20-25`. Each range may have part that comes before, completely overlaps, or comes after.

But it doesn't work to try to figure all this out from each mapping range, because this results in
duplicates that have to be uniq'ed. Instead, I first focus on identifying all the parts of the range
that were mapped, then filling in the remaining unmapped values to be the same as the source. It's easiest
to find unmapped values by sorting the mapped values and iterating them in order to find the gaps
between them.

Once all the result ranges are found in the last map, it's just a matter of finding the smallest starting
value.
