# Day 15: Chiton

[Full info here](https://adventofcode.com/2021/day/15)

Dijkstra with priority queue. Originally, I just dropped in a deque and
sorted it, but this ends up being very expensive. The STL's priority 
queue is much more effective for keeping the queue in order each iteration.

For part two, added a Scan class to handle expanding the grid size. Finding
the shortest path in the larger grid takes about a minute, so I'm sure there
are room for optimizations. 
