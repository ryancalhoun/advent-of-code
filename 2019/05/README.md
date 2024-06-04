# Day 5: Sunny with a Chance of Asteroids

[Full info here](https://adventofcode.com/2019/day/5)

This puzzle got a little complex. Doing my best to manage the complexity
with clean code.

I replaced the IntCode's operator if-else to a more general map lookup using
method references. Each operator has a single instance method that takes the
current index and returns an updated index. Yes, they have side effects too,
such as writing to memory.

I'm pretty happy with this result.
