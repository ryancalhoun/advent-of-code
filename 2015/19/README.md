# Day 19: Medicine for Rudolph

[Full info here](https://adventofcode.com/2015/day/19)

Languages:
* Perl
* NodeJS

I used Perl to preprocess the input data into Javascript variables, and
piped this as a script into Node.

The actual molecule counting is done in a separate NodeJS module. I could have
combined it all in one instead of requiring the separate .js file, but I wanted
to keep the syntax highlighting separate so I could tell what I was doing.

Part two, I discovered, was a bit tricky. The replacement rules define a "grammar"
that is completely unambiguous. There is only one way to get to the answer, not
multiples that have to be searched out.

Futher, I don't need to actually reduce the string rule-by-rule. I just need to
figure out how many replacements would have been done.

The rules are either:
* $x \to x \cdot x$
* $x \to x \cdot Rn \cdot x \cdot ( Y \cdot x )^\star \cdot Ar$

So each reduction is either two symbols to one, or a sequence that includes
$Rn$ then some number of $Y$ then $Ar$. $Rn$ and $Ar$ are always paired with each
other and two other symbols, and $Y$ is always paired with one symbol.

The number of reductions the total number of symbols in the input (the number of
capital letters, since symbols can be one or two characters), then subtract away
the number of $Ar$, $Rn$, and $Y$ pairs.
