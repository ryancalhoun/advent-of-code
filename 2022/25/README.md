# Day 25: Full of Hot Air

[Full info here](https://adventofcode.com/2022/day/25)

This was an interesting twist on a base number system. It ended up working
really well converting to decimal, simply multiplying by 5 and adding the
value of the current digit.

Going in the reverse direction was similar, except for the need to account
for negative digits. A multiple of 5, plus one or two is simple. But a
multiple of 5 plus 3 or 4 can't be represented. So, for those two cases,
I round up to the next muliple of 5, and treat the remainder as -2 and -1.
