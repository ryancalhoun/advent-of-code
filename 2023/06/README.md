# Day 6: Wait For It

[Full info here](https://adventofcode.com/2023/day/6)

## Part 1

>As part of signing up, you get a sheet of paper (your puzzle input) that lists the time
>allowed for each race and also the best distance ever recorded in that race. To guarantee
>you win the grand prize, you need to make sure you go farther in each race than the current
>record holder.

>The organizer brings you over to the area where the boat races are held. The boats are much
>smaller than you expected - they're actually toy boats, each with a big button on top. Holding
>down the button charges the boat, and releasing the button allows the boat to move. Boats move
>faster if their button was held longer, but time spent holding the button counts against the
>total race time. You can only hold the button at the start of the race, and boats don't move
>until the button is released.

>For example:
```
Time:      7  15   30
Distance:  9  40  200
```
>To see how much margin of error you have, determine the number of ways you can beat the record
>in each race; in this example, if you multiply these values together, you get 288 (4 * 8 * 9).

>Determine the number of ways you could beat the record in each race. What do you get if you
>multiply these numbers together?

## Part 2
>As the race is about to start, you realize the piece of paper with race times and record distances
>you got earlier actually just has very bad kerning. There's really only one race - ignore the
>spaces between the numbers on each line.

>So, the example from before:
```
Time:      7  15   30
Distance:  9  40  200
```
>...now instead means this:
```
Time:      71530
Distance:  940200
```

---

## Solution

For each race, with a given time `T` and record distance `D`, find all the (integer) values of
hold time `t` so that:

$$D < t \times (T-t)$$

A brute-force iteration of all times `0`-`T` works fine for the sample input, and part 1 completed
without issue.

However, for part 2 it is noticeably slow with the full input. The brute-force approach requires over
50 million iterations.

My initial run for part 2 produced a correct answer but took almost 10 seconds to calculate.

Cue algebra!

I can rewrite the above inequality in the form $ax^2+bx+c=0$, multiplying out and reordering the terms:
$$0 = -t^2 + Tt - D$$
So _a_=`-1`, _b_=`T`, and _c_=`-D`. The shape of the curve is an upside-down quadratic curve with the apex
at distance `D` above the _x_-axis. The two _x_-intercepts (really, they are _t_-intercepts) tell the
minimum and maximum times that will equal the record. Every value for _t_ inbetween these points beats the
record.

The quadratic formula gives as a solution for `t`:
$$t = \frac{-T \pm \sqrt{T^2-4D}}{-2}$$

All that appear in this formula are constants, the time and distance. Take the 3rd race in the sample as
an example, with time 30 and record 200.
$$t = \frac{-30 \pm \sqrt{30^2-4\times200}}{-2} = \frac{30 \pm \sqrt{900-800}}{2} = 15 \pm 5$$
The times `10` and `20`, which happen to work out to whole integers, will both tie the record. Times
`11` and `19` and everything inbetween will beat the record.

These values equal what is in the puzzle description:
>In the third race, you could hold the button for at least 11 milliseconds and no more than 19 milliseconds
>and still beat the record, a total of 9 ways you could win.

With that optimization in place, the same results can be calculated in negligible time.
