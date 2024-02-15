# Day 13: Transparent Origami

[Full info here](https://adventofcode.com/2021/day/13)

This was a fun puzzle. It's so cool to see letters pop out at the end.

I started out using a std::pair, then a std::tuple, to hold the dot coordinates.
But I needed to be able to dynamically get either the x or y value. Using
std::get would work but requires a constant expression.

I made a point class to hold the list of points, and used a std::set as the
list storage. Each fold, I iterate through the original set, and replace it
with a smaller folded set. This removes duplicates for points that line up
on top of each other.

