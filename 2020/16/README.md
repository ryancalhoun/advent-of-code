# Day 16: Ticket Translation

[Full info here](https://adventofcode.com/2020/day/16)

This puzzle was interesting, as it seemed complex, but ended up not being as
complex as it could have been.

For part one, identifying invalid fields. It's a pretty simple iteration once the
data is loaded. There could have been multiple invalid fields on a single ticket,
but there ended up being exactly 0 or 1 invalid fields per ticket. This was nice
because it allowed some code reused for part two.

Identifying the fields in part two could have been much more involved, like solving
a Sudoku puzzle. It ended up that a series of iterations could identify exactly
one field on each pass.

I first scan the fields of each ticket, and create the set of field names and the
list of each column that are possible. So every ticket must have a column which
passes the validation checks to be a possibility.

From the sample, it looks like this:

```
row   : 0 1 2
class : 1 2
seat  : 2
```

Initially, all the columns could be a `row` number. Column 0 cannot be `class` because
of the 3, and the 14 and 15 prevent columns 0 and 1 from being `seat`.

Since only one column could be `seat`, remove that column from consideration for any
other field.

```
row   : 0 1
class : 1
```

Now repeat. Since we removed 2, `class` has only a single possibility. Remove 1 from
consideration.

```
row   : 0
```

And once we get to the last field, we have all the data needed to find the six
departure values.
