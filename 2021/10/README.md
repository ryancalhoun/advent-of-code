# Day 10: Syntax Scoring

[Full info here](https://adventofcode.com/2021/day/10)

I am not super happy with how the code for this puzzle shaped up. It's an okay
solution, not a great solution.

I used virtual callbacks for illegal and incomplete characters, and a separate
implementation for the part one "syntax check" and part two "autocomplete".

Reading each line to identify the important characters was a straightforward
stack, just record the expecting closing symbol to go with each opening symbol.
I used a std::deque instead of a std::stack, because I needed to extract the
leftover characters at the end, and std::stack has no direct element accessor.
