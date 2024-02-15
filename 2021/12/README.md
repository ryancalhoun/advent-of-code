# Day 12: Passage Pathing

[Full info here](https://adventofcode.com/2021/day/12)

I simulated these caves as a map of names to lists of connections. To traverse
the network, I lookup a cave by name and iterate its connections.

The basic rules are pretty simple. You can visit a cave if its name is not "start",
if you have not visited it before, if its name is upper-case. For part one, that's it.

For part two, I keep track of visited caves with a counter. The small cave names all
have a counter value of 1, except a single counter with a 2.

So long as those rules are met, keep going and count the path.
