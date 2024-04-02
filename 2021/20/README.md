# Day 20: Trench Map

[Full info here](https://adventofcode.com/2021/day/20)

This puzzle begins with a straightforward 3x3 sliding window and a
lookup table. Each time the enhancement runs, the bounds of the image
grow by +1 on each edge. In other words, the output image's width and
height are each bigger by 2. Any further out is not necessary because
the window will miss all the image pixels.

This is all pretty simple if you make the assumption that the infinite
surrounding edges are all 0s. This works for the sample, because the
lookup table has a 0 out for 0 in.

But, if the lookup table has a 1 out for a 0 in, an infinite enhancement
would require setting the infinite edges all to 1s. Obviously, that is 
difficult to count. But if the max value of the lookup table is a 0,
the result of a second enhancement would flip all those infinite 1s back
to 0s.

So, each odd number of enhancements results in inifite 1s, and each even
number results in finite 1s.

Rather than represent this, I simply store the entire image as its own
inverse on every other operation.

With this all in place, the difference between running the operation
two times and fifty times is minimal.

