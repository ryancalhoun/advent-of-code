# Day 1: Report Repair

[Full info here](https://adventofcode.com/2020/day/1)


This puzzle was pretty simple and didn't require any optimizations. No sorting
or hashing, just simple list iterations.

For any `n` in the list, if there exists a value `v` such that `v=2020-n`, then
`n` and `v` are the pair. It doesn't matter which we find first.

I repeat this recursively (one level deep) for part two. To find a triple, I take
the diff with the target just like part one; then for this diff, I recurse down
using the diff as the new target.
