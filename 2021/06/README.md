# Day 6: Lanternfish

[Full info here](https://adventofcode.com/2021/day/6)

This puzzle was easy but also fun. I guess I correctly anticipated what the
part two wrinkle would be, because it didn't require any rework.

I did not store fish objects with counters in them.

Instead, I kept a single list where the index represents the numer of days,
and the value is the sum of fish with that counter. This works because all
fish with the same counter will always have the same counter, and they can
be treated as a group.

Each day, I remove first element, and add its value to the end. This has the
side effect of decrementing the counter for every other fish. Then add the
same value again at position 6. That's it.
