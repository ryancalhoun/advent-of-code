# Day 4: Scratchcards

[Full info here](https://adventofcode.com/2023/day/4)

The parsing is pretty simple for this, since the only ordering that matters is before or after the `|`.
There is no need to compare numbers within sets or across lines. Both parts requiring couting matches,
which is essentially counting a set intersection.

For part two, I use a hash to count copies of a card before actually getting to that card. Then, when I
arrive at a card, I check the number of copies I already have from previous rounds, and use that as a
multiplier.
