# Day 9: Mirage Maintenance

[Full info here](https://adventofcode.com/2023/day/9)

This puzzle lays out the algorithm pretty explicitly so there isn't a lot of
guesswork. The implementation is a fairly simple tail recursion.

The first wrinkle comes in the input parsing, since the full input has
negative values while the sample does not.

The second wrinkle is that the _next_ and _previous_ extrapolations could have
nearly identical implementations except for the recursive call. It is 
begging to be DRY'ed out.

I did this using Ruby blocks, but lambdas or callbacks in any other language
could do something similar. This allows a single recursive method to handle
both types of extrapolation and makes me happier.
