# Day 8

[Full info here](https://adventofcode.com/2023/day/8)

## Part 1

>One of the camel's pouches is labeled "maps" - sure enough, it's full of
documents (your puzzle input) about how to navigate the desert. At least,
you're pretty sure that's what they are; one of the documents contains a list
of left/right instructions, and the rest of the documents seem to describe some
kind of network of labeled nodes.

>This format defines each node of the network individually. For example:
```
RL

AAA = (BBB, CCC)
BBB = (DDD, EEE)
CCC = (ZZZ, GGG)
DDD = (DDD, DDD)
EEE = (EEE, EEE)
GGG = (GGG, GGG)
ZZZ = (ZZZ, ZZZ)
```

>Starting with AAA, you need to look up the next element based on the next
left/right instruction in your input. In this example, start with AAA and go
right (R) by choosing the right element of AAA, CCC. Then, L means to choose
the left element of CCC, ZZZ. By following the left/right instructions, you
reach ZZZ in 2 steps.

## Part 2

>After examining the maps a bit longer, your attention is drawn to a curious
fact: the number of nodes with names ending in A is equal to the number ending
in Z! If you were a ghost, you'd probably just start at every node that ends
with A and follow all of the paths at the same time until they all
simultaneously end up at nodes that end with Z.

>For example:
```
LR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11B, XXX)
22A = (22B, XXX)
22B = (22C, 22C)
22C = (22Z, 22Z)
22Z = (22B, 22B)
XXX = (XXX, XXX)
```

---

## Solution

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




