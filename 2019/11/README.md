# Day 11: Space Police

[Full info here](https://adventofcode.com/2019/day/11)

Aside from the existing IntCode implementation, I used an x,y point to 
track position and a 2-d direction vector that I could update with 90
degree rotations.

I stored the panel locations in a Map to accomodate inifinite positions,
though it looks like a relatively small 2-d array would have worked just
as well.
