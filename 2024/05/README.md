# Day 5: Print Queue

[Full info here](https://adventofcode.com/2024/day/5)

My solutions for this were suboptimal. I stored the rules as a list to
check against each sequence.

To check if a sequence is valid, I check the two pages in each rule
against the relative ordering of pages in the sequence.

For part two, I use a bubble sort. Instead, I can think of two other
solutions. If I can rely on the rules to produce a strict less or
greater for each pair of pages, I can obviously use a more optimal
sort. Or, instead of attempting to sort I can use a counting technique
to identify which element is the middle without sorting. But it works
and the dataset isn't large enough to matter.
