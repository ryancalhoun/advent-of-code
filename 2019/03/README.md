# Day 3: Crossed Wires

[Full info here](https://adventofcode.com/2019/day/3)

This was my first ever use of Java lambdas. It's interesting how similar
lambda syntax can look between languages, yet rules around local variable
binding are so different. In Java, only final variables are allowed. That's
very interesting.

The first step was to build each wire's path. The next is to traverse each
pair of wire segments looking for intersections.

Because part one is looking for a minimum distance, I have to keep track of
the current minimum value, but only compared with the current point.

Because part two needs a path length, I have to keep a path accumulator for
each wire's segments. I need a sum of all the complete segments already seen,
plus the partial distance to the intersection point. As long as the traversal
happens in the order the wire is defined, this ought to work.
