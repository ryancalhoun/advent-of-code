# Day 10: Adapter Array

[Full info here](https://adventofcode.com/2020/day/10)

This puzzle needed a clever solution.

Both parts begin by producing a sequence of diffs between sorted values. So an
input sequence like:

```
(0) 1 4 5 6 7 10
```

will produce an output like:

```
1 3 1 1 1 3
```

Part one's answer simply requires bucketing the diffs to count the total occurrences
of each.

Part two require's counting consecutive `1`s. We can ignore diffs of `3` because that
is already the maximum difference and nothing can be changed without creating an invalid
chain. But with enough `1`s, we can remove the middle values and still have a valid
chain.

For example, three in a row produces two possibilities:

```
1 4 5 6 9
1 4   6 9
```

Four in a row produces four:

```
1 4 5 6 7 10
1 4 5   7 10
1 4   6 7 10
1 4     7 10
```

And five in a row produces seven:

```
1 4 5 6 7 8 11
1 4 5 6   8 11
1 4 5   7 8 11
1 4 5     8 11
1 4   6   8 11
1 4   6 7 8 11
1 4     7 8 11
```

It doesn't matter where in the sequence these diffs occur. Once they are identified and
counted, the final answer is just multiplying by 2, 4, and 7.
