Day 5: Hydrothermal Venture

[Full info here](https://adventofcode.com/2021/day/5)

I looked at this puzzle for a while as a line intersection problem. It was not
too difficult to identify all intersecting and overlapping segments, while only
storing the endpoints of each line.

Once I realized this overcounts the actual answer, I scrapped most of it. We are
counting points that overlap at least once, meaning we don't want to count any
given point more than once.

Without needing to compare lines to other lines, it was just a matter of iterating
and counting all the points.
