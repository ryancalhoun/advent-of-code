# Day 4: Security Through Obscurity

[Full info here](https://adventofcode.com/2016/day/4)

To solve this, I mostly treated strings like numeric vectors.

I kept my outer loop reading and checking line-by-line. Probably I could
improve this by reading the entire input as a Matrix and finding a way
to vectorize the entire thing. The difficulty would be varying line
lengths.

For now, this works okay.
