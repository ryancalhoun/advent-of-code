# Day 8

[Full info here](https://adventofcode.com/2023/day/8)

Part one is a pretty simple graph problem. Find a path than includes cycles. My graph
is not stored and linked like an actual graph. It's just a single map with lookups
for each node name.

Part two gets interesting. The simultaneous traversal itself isn't a problem, but the
ultimate length of the path is.

I end up relying on two key assumptions which were not explicitly called out in
the description:

* The path length will always be an exact multiple of the list of directions.
* A path will not cross through the ending node of another path.

Given these two assumptions, I can treat each path as independent from all the others.
Each path will follow the same directions each time through because it will have
completely used up its direction list each time. No need to carry over half a list.

It also means that the problems becomes a least common multiple problem. I don't need
to actually make the graph traversal happen the full number of iterations. I only
need to find the length of each independent path, and know that the stopping
condition will happen for all of them when I reach the least common multiple of all
path lengths.




