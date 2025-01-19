# Day 3: Mull It Over

[Full info here](https://adventofcode.com/2024/day/3)

I thought about building a legitimate statemachine to process the
input character-by-character. I settled for using regexes to scan
for matches.

For part one, just a regex to capture the entire `mul(x,y)` string
and convert the arguments to integers.

For part two, I pre-process the string looking for `don't()...do()`
sequences to remove. The first wrinkle is regex needs to be told
to carry-over new lines. The second is that the last `don't()` may
continue to the end of input and not end with a closing `do()`.
