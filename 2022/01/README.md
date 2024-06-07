# Day 1: Calorie Counting

[Full info here](https://adventofcode.com/2022/day/1)

I chose to implement this using a list of lists. Technically, a list of hashes of lists. A list
of elves each storing a list of calories, among other things (though nothing else was necessary).

It turned out not to be necessary. A minimal implementation would only need an accumulator for the
current sum, and a variable to hold the current max (for part two, a list of three, potentially).

But, I do prefer the flexibility the results from building the data structures to mirror the data,
and choosing how to process it later.
