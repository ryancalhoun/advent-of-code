# Day 9: Encoding Error

[Full info here](https://adventofcode.com/2020/day/9)

I store the list of numbers, as I read each, as a list of hashes. One
special value `{value}` is the number. The remaining hash keys are the
sums of that number with all the numbers that come after. Or at least,
the `window-size` numbers that come after.

From the sample, I'd read the first five numbers and have computed:

```
35: 55 50 60 82
20: 35 45 67
15: 40 62
25: 72
47:
```

So when I read the next number, `62`, I expect to find it in this set.

If I find `62` (and I do) then I add it to the previous 4 numbers:

```
20: 35 45 67 82
15: 40 62 77
25: 72 87
47: 109
62:
```

Then repeat, until the next number is not found within the window.

For $n$ numbers with a window size of $w$, the storage and computational
cost are both $n\times{w}$. If I instead chose to search for a pair for
every number, storage cost would be $n$ and computation would be $n\times{w^2}$.

---

For part two I throw away the pre-computed sums, since these only work
for pairs.

Instead I search possible ranges from indexes $i$ to $j$. Because $i$ and $j$
can both cover almost the entire range, this is at worst an $O(n^3)$ approach.
Indeed, if I begin with $i=0$ and $j=1$, searching from the smallest numbers
first, the ranges grow very large and performance does approach the worst case.

But, if I begin with $i=n-2$ and $j=n-1$, searching from the biggest numbers
down, the ranges tend to be small. The worst case under these circumstances
would be to find a large range with a small value for $i$--however, because I
can eliminate the big ranges so quickly, the observed performance would be
much closer to $O(n^2)$.
