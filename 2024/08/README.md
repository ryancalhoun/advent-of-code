# Day 8: Resonant Collinearity

[Full info here](https://adventofcode.com/2024/day/8)

I feel like I'm getting the hang of go. At least starting to. I'm
not convinced that I like it yet.

For this puzzle I stored a map of frequencies to a list of points.
This allows comparing all like frequencies against each other.

For each pair of frequencies, find the `dx` and `dy` between them.
It helps to decide which point is first and which is second. I chose
the left-most (lowest x) to be first. So the `dx` is always positive and
the `dy` can be positive or negative.

For part one, move one `dx,dy` to the left of the left-most. Move one
`dx,dy` to the right of the right-most.

For part two, it's a loop, but also setting the starting points.

In both cases, a map of points holds the set of unique locations.
