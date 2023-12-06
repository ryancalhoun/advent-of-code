# Day 5: If You Give A Seed A Fertilizer

[Full info here](https://adventofcode.com/2023/day/5)

## Part 1
>The almanac (your puzzle input) lists all of the seeds that need to be planted.
>It also lists what type of soil to use with each kind of seed, what type of fertilizer
>to use with each kind of soil, what type of water to use with each kind of fertilizer,
>and so on. Every type of seed, soil, fertilizer and so on is identified with a number,
>but numbers are reused by each category - that is, soil 123 and fertilizer 123 aren't
>necessarily related to each other.

>For example:
```
seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4
```
>With this map, you can look up the soil number required for each initial seed number:
>- Seed number 79 corresponds to soil number 81.
>- Seed number 14 corresponds to soil number 14.
>- Seed number 55 corresponds to soil number 57.
>- Seed number 13 corresponds to soil number 13.

>What is the lowest location number that corresponds to any of the initial seed numbers?

# Part 2
>Everyone will starve if you only plant such a small number of seeds. Re-reading the almanac,
>it looks like the seeds: line actually describes ranges of seed numbers.

>The values on the initial seeds: line come in pairs. Within each pair, the first value
>is the start of the range and the second value is the length of the range.

---

## Solution
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
