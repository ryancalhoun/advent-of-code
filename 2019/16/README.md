# Day 16: Flawed Frequency Transmission

[Full info here](https://adventofcode.com/2019/day/16)

This one was tricky, and parts 1 and 2 were pretty different.

For part one, I kept a data array of 650 integers, and index arrays for
all the indexes to add and subtract for each output digit. I compute the
add and subtract arrays as each 4th element to follow the `0, 1, 0, -1`
pattern. These can be offset and repeated for each output digit placement.

For part two, the offset into the large dataset takes us so far down into
the pattern that all that's left is an upper-triangle of `1`, like

```
11111
01111
00111
00011
00001
```

To compute each phase, I hold only the part of the data after the offset,
about 500,000 integers. I fill in each output starting from the end, as
`out[i] = in[i] + out[i+1]`. So the result is a linear operation instead
of quadratic.
