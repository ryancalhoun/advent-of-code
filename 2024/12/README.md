# Day 12: Garden Groups

[Full info here](https://adventofcode.com/2024/day/12)

This code got kind of ugly. I should probably have split the pieces
apart more. The `garden` object ended up with lots of private helper
classes.

First, I needed to implement a set union. As I scan the garden plots,
I identify immediate neighbors north and west. This makes it easy to
go row by row, left to right. Any time the immediate neighbor is a
match, the two groups get joined. The result of this is that any
previously joined plots will also become part of the final group.

Once I've preprocessed the plots into groups, each group needs fence
along each outer face. I model this at each plot point with a fence
that may exist on the north, south, west, or east face. Comparing
each plot against its own neighbors in the group, then removing faces
that would touch (interior faces) results in only the external faces
left.

I further process these fence faces into linear values along the side.
For north and south (horizontal) this means lists of `x` for each `y`.
For east and west (vertical), lists of `y` for each `x`.

Part one just needs to count the number of points set.

Part two looks at the linear ranges, and counts each grouping of
consecutive values. So `1,2,3` is one, and `1,2,3,5,6` is two.
