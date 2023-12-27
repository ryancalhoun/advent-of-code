# Day 14: Parabolic Reflector Dish

[Full info here](https://adventofcode.com/2023/day/14)

## Part 1

>In short: if you move the rocks, you can focus the dish. The platform even has
a control panel on the side that lets you tilt it in one of four directions!
The rounded rocks (O) will roll when the platform is tilted, while the
cube-shaped rocks (#) will stay in place. You note the positions of all of the
empty spaces (.) and rocks (your puzzle input). For example:
```
O....#....
O.OO#....#
.....##...
OO.#O....O
.O.....O#.
O.#..O.#.#
..O..#O..O
.......O..
#....###..
#OO..#....
```

>Start by tilting the lever so all of the rocks will slide north as far as they
will go:
```
OOOO.#.O..
OO..#....#
OO..O##..O
O..#.OO...
........#.
..#....#.#
..O..#.O.O
..O.......
#....###..
#....#....
```

>The total load is the sum of the load caused by all of the rounded rocks. In
this example, the total load is 136.

>Tilt the platform so that the rounded rocks all roll north. Afterward, what is
the total load on the north support beams?

## Part 2

>Each cycle tilts the platform four times so that the rounded rocks roll north,
then west, then south, then east. After each tilt, the rounded rocks roll as
far as they can before the platform tilts in the next direction. After one
cycle, the platform will have finished rolling the rounded rocks in those four
directions in that order.

>In the above example, after 1000000000 cycles, the total load on the north
support beams is 64.

>Run the spin cycle for 1000000000 cycles. Afterward, what is the total load on
the north support beams?

---

## Solution

For this puzzle I chose to keep the fixed rocks stored in two hashes, one by
row and one by column. This way, I could always look up all the fixed rocks
in-line with a given rolling rock, whether north/south or east/west.

For the rolling rocks, I just store a list of each rocks current `i,j`
position.  None of the operations needed for this puzzle require anything more
sophisticated.

To accomplish a tilt, I create buckets "uphill" of each fixed rock, then
count how many rolling rocks are in that bucket. Then I just update the `i` or
`j` value for each rock based on the number in the bucket. It doesn't necessarily
matter if the rocks stay in order for this step.

For part two, I created a second type of score. The "load score" might have worked
but would be ambiguous for east/west movements. I wanted a score that would be
unique for positions of all rocks. Then, I ran cycles on the grid until the scores
started to repeat.

After quite a few cycles, but far less than a billion, the rolling rocks will
reach a steady state and come to rest in the same configurations again and again.
Once I can identify where a repeated patten of scores begins and ends, extrapolation
is simply figuring out where in the pattern the billionth cycle would fall.

