# Day 2: Corruption Checksum

[Full info here](https://adventofcode.com/2017/day/2)

Well, Node is weird. If I have two strings and add them, I get a
concatenation--makes sense. I have to `parseInt` each value before
adding so they are treated like numbers.

But...then I take an array of numbers (which behave like numbers in
all other contexts) and by default the `sort` function sorts them
alphabetically. Hmm.

Like I said, weird.
