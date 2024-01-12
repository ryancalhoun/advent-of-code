# Day 15: Beacon Exclusion Zone

[Info here](https://adventofcode.com/2022/day/15)

Part one of this puzzle was just reducing overlapped ranges.

The ranges come from the width of each sensor's diamond at a particular
y-value.

```
1  ..#..
2  .#.#.
3  #...#
4  .#.#.
5  ..#..
```

If you have a sensor with radius 2 at (3,3), then the width is obviously
the greatest at y=3, and grows smaller as you move away. At y=3, x is
covered from 1 to 5, at y=4, x is covered from 2 to 4, and at y=5, x is
only covered at 3.

For a given y-value, for all sensor diamonds, how much of the diamond
overlaps that row. Take those individual x-ranges and find their unions.

Part two was much more fun.

My initial idea was to take my part one solution and run it for each
possible y-value within the target range. It worked, but took several
minutes to crank through the four million possibilities.

I considered transforming each sensor diamond into a height map, where
the max value would be in the center, and shrink to zero at the edge.
Summing the heights for overlapping sensor areas would produce an
interesting surface, and possibly some way to search for the single
point with a zero value. That also sounded pretty complex.

Ultimately, I decided to find the intersection points between the
sensor diamonds. Specifically, the uncovered perimeter that lies one
unit beyond the covered area.

```
1  ....A...B....
2  ...A.A.B.B...
3  ..A...X...B..
4  .A...B.A...B.
5  ..A.B.A.....B
6  ...A.X.....B.
7  ....A.B...B..
8  .......B.B...
9  ........B....
```

So if there are two diamonds A and B which have intersecting edges, these points
mark places where neither diamond is covering.

Obviously, all points beyond the edges would also not be covered by these
two.

But, when you take all diamonds into account and assume there is a single
uncovered point, that point must lie on at least one such intersection.

In this way, I was able to reduce the search area from four million down to
a few hundred.

