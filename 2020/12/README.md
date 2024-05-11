# Day 12: Rain Risk

[Full info here](https://adventofcode.com/2020/day/12)

Navigating the boat around for part one is pretty straightforward.
Following the rules for each instruction, we can just update the
boat's x-y position and the direction it's facing.

But, to better accommodate part two, I implemented the waypoint
pattern for part one as well. So, in part one I keep a waypoint
that starts at one unit east. Instead of updating a direction,
I rotate the waypoint around, always at a distance one one. And
the move forward moves `n` units toward the waypoint.

This way, the only difference needed for part two (beside the
initial position) is that the waypoint updates for each N, S, E, W
move instead of the boat itself.
