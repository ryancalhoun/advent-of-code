# Day 14: Docking Data

[Full info here](https://adventofcode.com/2020/day/14)

For this puzzle I created a separate implementation of a memory layout,
one for part one's value masking, and a second for part two's memory masking.

Part one: I converted each mask into two binary bitmasks, one to be ANDed and
one to be ORed.

For example (with just 8 bits)

```
mask   = XXXX1X0X
ones   = 00001000
zeroes = 11111101
```

And then the value becomes `value & zeroes | ones`.

Part two: This was way more tricky. I was overcounting at first at it took
a while to figure out why. My strategy was to store the memory location as
the mask result and not convert it to a number at all.

For example

```
mask     = X1001X
addr(42) = 101010
result   = X1101X
```

So then I store the value using `X1101X` as my location. Later, when
summing values, I count 2 `X`s in the key and multiply the value by 4 since
there are 4 coipes of it.

The next step in the process is to detect existing keys which will be partly
or totally covered by new keys.

```
mask     = 00X0XX
addr(26) = 011010
result   = 01X0XX
```

Adding this new key with 3 `X`s will result in 8 copies of the value. BUT, it
also covers two copies of an existing value. I need to detect this overlap
and slice the old keys into non-overlapping locations.

Compare the two bit-by-bit:

```
NEW  01X0XX
OLD  X1101X
```

Any place the old key has an `X` and the new key has a 1 or 0, I replace the
`X` with the opposite. This becomes `11101X`.

Below is another example in which multiple `X` bits overlap. To avoid
overcounting, I cannot represent all slices with the same number of `X`s, so
I instead copy down the original 1 or 0 (not the opposite) from the new key,
in a triangular manner.

```
NEW   00101X011
OLD   XXXX1X0XX
slice 1XXX1X0XX
slice 01XX1X0XX
slice 000X1X0XX
slice 00111X0XX
slice 00101X00X
slice 00101X010
```

The first slice with 6 `X`s accounts for all possibilities that start with 1,
so all other slices start with 0. Replace the `X` with the new bit's opposite
for a single slice, then set it to the new bit's equal from then on.

In this manner physical storage required does grow each time a new value is
added and also each time a location overlaps. But it only grows according to
the number of `X` bits that overlap rather than the actual number of virtual
memory locations.

If there are 10 `X` bits that overlap a key, I add 10 new key slices instead
of 1024 individual permutations.


