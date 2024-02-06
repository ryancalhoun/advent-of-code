# Day 4: Giant Squid

[Full info here](https://adventofcode.com/2021/day/4)

This puzzle was a fun use of several STL containers.

I chose to store the rows of each Bingo board sequentially in a single
vector of length 25. So on finding the index of any given number, its row
is `i / 5` and its column is `i % 5`.

Rather than spend time iterating through all possible rows and columns to
find a winning board, I just kept a tally of rows and colums for each 
board and incremented for each number. So if the number in row 3 and column
2 is called, I increment my counters for row 3 and column 2. A board wins
when one of these counters equals 5.

I also keep track of which numbers have been matched on each board, as a way
to find the sum of numbers that haven't been called.

For part two, it is possible for multiple boards to win per round. I made one
assumption that is not represented in code: that is, the first and last winners
will happen in a round on their own, so there is no ambiguity about which is
first or last. The puzzle description would have needed to specify rules to break such
ties if this assumption didn't hold true.
