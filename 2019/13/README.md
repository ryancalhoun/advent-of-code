# Day 13: Care Package

[Full info here](https://adventofcode.com/2019/day/13)

There is a lot of extra info in this puzzle that can be filtered out.
Only the number of blocks matters, not the placement, and not the walls.

The paddle and ball need to be close in the x-direction, so I just move the
joystick by the difference between them. It turns out the difference is
never more than one, so this works.

I just keep signaling until the program halts. No need to keep track of
blocks as the game runs.
