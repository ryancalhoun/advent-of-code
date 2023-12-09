# Day 9: Mirage Maintenance

[Full info here](https://adventofcode.com/2023/day/9)

## Part 1

>You pull out your handy Oasis And Sand Instability Sensor and analyze your
surroundings. The OASIS produces a report of many values and how they are
changing over time (your puzzle input). Each line in the report contains the
history of a single value. For example:
```
0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45
```

>If you find the next value for each history in this example and add them
together, you get 114.

>Analyze your OASIS report and extrapolate the next value for each history. What
is the sum of these extrapolated values?

## Part 2

>Of course, it would be nice to have even more history included in your report.
Surely it's safe to just extrapolate backwards as well, right?

>For each history, repeat the process of finding differences until the sequence
of differences is entirely zero. Then, rather than adding a zero to the end and
filling in the next values of each previous sequence, you should instead add a
zero to the beginning of your sequence of zeroes, then fill in new first values
for each previous sequence.

>Adding the new values on the left side of each sequence from bottom to top
eventually reveals the new left-most history value: 5.

>Doing this for the remaining example data above results in previous values of
-3 for the first history and 0 for the second history. Adding all three new
values together produces 2.

---

## Solution

This puzzle lays out the algorithm pretty explicitly so there isn't a lot of
guesswork. The implementation is a fairly simple tail recursion.

The first wrinkle comes in the input parsing, since the full input has
negative values while the sample does not.

The second wrinkle is that the _next_ and _previous_ extrapolations could have
nearly identical implementations except for the recursive call. It is 
begging to be DRY'ed out.

I did this using Ruby blocks, but lambdas or callbacks in any other language
could do something similar. This allows a single recursive method to handle
both types of extrapolation and makes me happier.
