# Day 6: Wait For It

[Full info here](https://adventofcode.com/2023/day/6)

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
