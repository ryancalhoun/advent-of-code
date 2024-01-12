# Day 18: Boiling Boulders

This puzzle lent itself extremely well to Python's functions,
moreso than anything object-oriented. I think the reason is
the way this particular problem space can be broken down.

Mostly, I can deal with the cubes in a single dimension at a time.

For the cubes at (x,y,z), I record that:
```
(y,z) = [x, ...]
(x,z) = [y, ...]
(x,y) = [z, ...]
```

The result, a list of (x) values along a single (y,z) line, can
then show which cube faces are adjacent and do not count toward
the overall surface area.

For each adjacent pair of cubes, two faces are removed from the
total.

I first count all x-facing adjacent faces, then y-facing, then
z-facing.

For part one, that's it. Nothing has to be put back together.

For part two, I have to identify which of those cubes are completely
enclosed. For this I start in the same way but look for gaps
between cube faces, individually in each dimension.

```
###.#
##.##
#####
```

Here, the gap in the top row happens to be open to the outside. The
gap in the middle row is enclosed. The difference is apparent if
you look at the columns instead of the rows, and the first gap
is not a gap at all in that direction.

In three dimensions, an enclosed space will appear as a gap between
faces in all three (exactly three) dimensions.

It's a little more complicated, since multiple adjacent gaps may
form a larger interior pocket. Also, a gap may appear to be enclosed
initially, but actually have a pathway to the outside.

```
###.#
#...#
#####
```
Here, two gaps appear enclosed if looking strictly at the x or y
directions only. But since one of these spaces is directly adjacent
to a gap that isn't enclosed, then none of them would count.

I decided to re-use the implementation I'd already built to find the
surface area for part one. But what I did was use my three-dimensional
gap counting to re-build a new list of cubes to take the space of the
interior vacuum, then find its surface area. The surface area of this
imaginary shape equals the inward facing area of the real shape that we
are trying to ignore.

It becomes a two-deep recursion, with the inner total subtracted from the
outer.
