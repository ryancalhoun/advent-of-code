# Day 18: Operation Order

[Full info here](https://adventofcode.com/2020/day/18)

I liked this puzzle. This used a good combination of fun techniques.

For data, I parse the input tokens into an array of arrays. The outer array
is, of course, a stack--the last(top) element represents the current sub-expression,
i.e. the part in parentheses. A `(` means push a new level, and a `)` means to
pop and append the result to the new top.

My outer class `Evaluate` represents parsing and parens. It is handed an
evaluator function at creation which handles each sub-expression.

For part 1, a left-to-right implementation. For part 2, and add-before-multiply
implementation.
