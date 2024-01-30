# Day 21: Monkey Math

For this puzzle, I built a tree of monkies using python's lambda. This allowed
me to parse each line up-front, but delay the actual execution until all the 
input is read.

The fun comes in part two, which turns arithmetic into algebra. I created a
psedo-integer object which implements all the expected operations. But instead
of performing the calculation, I push the inverse operation onto a stack. Again,
using lambda.

So if I encounter a operation like $ x + 2 $, I record that as
* Subtract 2

And a more complex expression like $\frac{3(x+2) - 5}{4}$, will become
* Multiply by 4
* Add 5
* Divide by 3
* Subtract 2

This corresponds to the operations I would perform on the opposite side of
an equality to isolate $x$ and find its value.

So my equation would become:

$$
\begin{aligned}
\frac{3(x+2) - 5}{4} & = 4 \\
      3(x+2) - 5     & = 4\cdot{4} \\
      3(x+2)         & = 16 + 5 \\
        x+2          & = 21\div{3} \\
        x            & = 7 - 2 \\
        x            & = 5
\end{aligned}
$$

To solve part 2, I just drop my unknown object in place of monkey 'humn' and
override the equality operator to return the result of the inverse operations.

Yes, I am abusing the equallity operator to perform a calculation and return
non-boolean result. The world won't melt.
