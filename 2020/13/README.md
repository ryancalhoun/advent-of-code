# Day 13: Shuttle Search

[Full info here](https://adventofcode.com/2020/day/13)

Fun playing with numbers.

For part one, `ceil(t0 / id) * id` is the soonest time each bus arrives after `t0`. Just sort and
find the smallest.

For part two, `(t + offset) % id == 0` is true for each bus that arrives the correct time after bus
zero. This will be true for all buses simultaneously when `t` is the correct answer. As we get to
each bus's correct arrival interval, increment by larger and largest steps. The final answer should
be a multiple of the repeating interval for each bus.
