# Day 3: Spiral Memory

[Full info here](https://adventofcode.com/2017/day/3)

This puzzle was interesting. The obvious way to solve it would have been
to just set up a grid and traverse it in a spiral to fill all the values.
This would have worked for both parts.

Here is what I did instead.

## Part 1

First I find the depth--the number of rings out from the center.
Each ring contains `8 * depth` numbers. The first ring has 8, the second has
16, the third has 24. When you add the center plus each ring, you get the
expected perfect squares: `3x3`, `5x5`, `7x7`, and so on.

Then, I find the remainder of the value once I subtract away the number of
values from all the inner rings.

From the sample values:
```
12 - 3*3 = 3
23 - 3*3 = 14
1024 - 31*31 = 63
```

Read these as like this:
* 12 is the 3rd number in the 2nd ring, because we subtracted the 3x3 square
  formed by the completed 1st ring and the center value.
* 23 is the 14th number in the 2nd ring.
* 1024 is the 63rd number in the 16th ring, because we subtracted the 31x31
  square from the 15 completed rings inside it.

Since we have the depth, we know one of the Manhattan dimensions. The distance
will be the depth, plus some number of steps from the center toward a corner.

Next, we have to find the current value in relation to the nearest corner in
its ring. Each ring has four sides with an odd number of values. The center is
already aligned with the overall center so it adds 0. Each space away from the
center adds 1.

I use this expression: `abs( (8*depth - remainder) % (2*depth) - depth)`. Here,
`remainder` is result of the subtraction above.

From the sample:
```
abs( (8*2 - 3) % (2*2) - 2 ) = 1
abs( (8*2 - 14) % (2*2) - 2 ) = 0
abs( (8*16 - 63) % (2*16) - 16 ) = 15
```

So 12 is 1+2=3 steps, 23 is 0+2=2 steps, and 1024 is 15+16=31 steps.

## Part 2

I realized here that I don't need to store the complete grid. I only need the
previously completed ring, plus the current in-progress ring.

So I begin with an inner ring of `[1]` to represent the center, and an in-progress
ring of 8. On the next iteration, my inner ring would be size 8 and the current
ring 16.

For this part it's important to identify 3 cases:
* Approaching a corner (1 space away)
* On a corner
* Leaving a corner.

If we are approaching a corner, we add the last value from the current ring, and
two values approaching the same corner from the inner ring.

If we are on a corner, we again add the last value from our own ring, and only 
the a single corner value from the inner ring.

As we leave the corner, add the last two from our own since we just bent around
a corner, and two leaving the corner from the inner ring.

All other cases are moving along the outer edge, and add the last current ring
value plus 3 from the inner ring.

On the final side, the final two values on the current ring will add the first
value, as it becomes a neighbor to close out the square.

From the sample, in the 2nd ring:
* 26 is leaving a corner, and the first value has no previous: `25+1`
* 54 is in the middle, `26 + (25+1+2)`
* 57 is approaching a corner, `54 + (1+2)`.
* 59 is a corner, `57 + 2`
* 122 leaving a corner, but now it does have two previous values: `(57+59) + (4+2)`

And so on.



