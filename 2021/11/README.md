# Day 11: Dumbo Octopus

[Full info here](https://adventofcode.com/2021/day/11)

For this puzzle I linked up all the neighboring octopi upon loading the 
input data. So my cave has a flat list of octopi, and each octopus has 
a flat list of its neighbors.

The flashing is accomplished with a queue. On each step, load up all
octopi into the queue. For each octopus in the queue, increment. If the
octopus flashes, re-queue its neighbors. Keep going until the queue is
empty.
