# Day 14: Parabolic Reflector Dish

[Full info here](https://adventofcode.com/2023/day/14)

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

