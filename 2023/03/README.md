# Day 3: Gear Ratios

[Full info here](https://adventofcode.com/2023/day/3)

This puzzle doesn't work as naturally with regexes as most of the others. This one lends itself more to
char-by-char input.

I chose to read line-by-line and char-by-char, and increment `i, j` counters as I went. Consecutive digits
turn into numbers, but it's important to track the location of the number as well as its length. So the value
`664` starts at `9, 1` and ends at `9, 3`. An adjacent symbol could have an `i` value from `8-10` and a `j`
value from `0-4`. It's actually simpler to allow diagonally adjacent values than it would be to rule them
out.

I chose to only store lists of numbers and symbols, not the entire grid. Storing the grid as a whole is
wasteful, especially if the grid is sparse, and iterations to find adjacency involves messy 4-deep nested
loops. Instead, I store each number in a flat list with its `i, j` values, and each symbol in a hash with
all the symbols in row `i` stored in `hash[i]`.

To find adjacent numbers and symbols, assuming _n_ numbers and _m_ symbols, is computationally _O(n*m)_ in
the worst case, where both _n_ and _m_ are significantly smaller than _i_ and _j_. As an optimization, I
only look at symbols stored in `hash[i-1]`, `hash[i]`, and `hash[i+1]`. Doing this brings the amortized
complexity much closer to _O(n*j/m)_.

For part two, while iterating the numbers for the first pass to find adjacent symbols, I link each number
to the symbol. Once this is complete, I make second pass to iterate the symbols to find those that have
exactly two numbers linked.



