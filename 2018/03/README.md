# Day 3: No Matter How You Slice It

[Full info here](https://adventofcode.com/2018/day/3)

My data for this puzzle was a dictionary of `tuple<x,y>` to `list<id>`.
I just flood the area, each `x,y` point within a claim, with the claim
ID. Since the dictionary holds a list for each location, overlapping
claims will have lists with more than one element.

To find the non-overlapping claim, I fill a set with the IDs of each
list element of overlaps. The result will be the single ID that is not
in that set.

I find that I do not like C#'s `using` directive in lieu of typedef. I
need to find a better way to compose types.
