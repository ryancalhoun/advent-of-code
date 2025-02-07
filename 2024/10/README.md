# Day 10: Hoof It

[Full info here](https://adventofcode.com/2024/day/10)

This was fun. Probably my most nested single data structure so far.
A list of map of point to map of int to int.

That is, a list where the index is the height 0-9. Of maps of x,y points
at each height. To a map of the ID of whichever 9 the current spot leads
to, to the count of how many overlapping trails branch off but go back
to the same end.

No recursion. I work backwards starting with 9, and give each ending a
unique ID. From each 9, I look up possible neighbors from the list of
8s--then add one for the current ID.

Then for each 8, look up neighbors in the list of 7s, and add any
matching IDs for all possible endings. And on and on, back to each
zero.

For part one, the answer is the number of items in each map for all
the zeros.

For part two, it's the sum of the count values in each map.
