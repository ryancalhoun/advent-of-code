# Day 24: Blizzard Basin

[Full info here](https://adventofcode.com/2022/day/24)

My first step here was to model the movements of the blizzards.
Because they all move at the same rate, never changing direction, and
recycle on the opposite side, it's pretty simple to model them in groups.

So instead of tracking each blizzard individually, I track them according
to their direction. All the north-moving blizzards are part of the same set,
and so on. All the north-moving blizzards on the same row will always be on
the same row. And all the east-moving blizzards on the same column will always
be on the same column. Knowing this, I can calculate the position of any
blizzard at any point in time.

More importantly, I can find empty spaces in the valley at any point in time.

In order to find the path across, I simply track the neighboring openings at
each next point in time. At each minute, I replace the previous set with the
one I just found, and start again. So I'm not actually finding a path at all,
just waiting until one of open neighbors is equal to the finish.

At worst, this is an $O(n^2)$ approach. But, the worst case only happens with
no blizzards, and I'd still hit the finish before reaching the upper bound.

In practice, the more blizzards the better, since that keeps the number of
available neighbors small.
