# Day 7: Handy Haversacks

[Full info here](https://adventofcode.com/2020/day/7)

This puzzle was fun! Solved without recursion, by making multiple iterations through
the rules. I store the rules as a hash of hashes: `parent-color` to `child-color` to
`quantity`.

For part one, find the parents. Make a pass through the rules. Any color with "shiny
gold" as a child gets counted. Now ignore "shiny gold" and instead keep a list of the
parent colors we just found (if they haven't already been found). Make another pass
through the rules looking for children with those colors. And so on, until we run out
of parent colors to look for.

For part two, children. Make a pass through the rules. We are looking for any parent
who has zero children or whose children have *all* been found. Add one for the parent
and `quantity` times the previously found child value. As we find more values, we are
able to find more parents on the next pass. Keep going until all colors have a value.
We could, I suppose, short-cut and stop once "shiny gold" has been found, but the 
runtime performance is already fine without additional optimizations.
