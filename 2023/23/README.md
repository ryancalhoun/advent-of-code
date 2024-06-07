# Day 23: A Long Walk

[Full info here](https://adventofcode.com/2023/day/23)

This one was tough. I have no idea how to implement a longest-path algorithm
other than brute force, and have nowhere near an optimal solution.

For part 1:
```
$ time rake run PART=1 > /dev/null
ruby app.rb full.txt

real    0m0.211s
user    0m0.162s
sys     0m0.021s
```
And for part 2:
```
$ time rake run PART=2 > /dev/null
ruby app.rb full.txt

real    5m11.788s
user    5m11.720s
sys     0m0.043s
```

What I decided to do was a two-phase traveral of the map. First, I would identify
the start and end points of all path segments. Any time I got to a junction with
more than one way to go, I'd cut off the segment and start a new one for each
direction.

Then, taking all those segments, I could build a new reduced graph by joining
each of the overlapping start and end points. In this way, I reduced a
19,000-something node graph into a 30-something node graph.

So my brute force search for the longest path was done over a much smaller set
of nodes. Still very slow, but possible.

Maybe I'll return to this one in the future.
