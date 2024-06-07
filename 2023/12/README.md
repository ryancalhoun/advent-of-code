# Day 12: Hot Springs

[Full info here](https://adventofcode.com/2023/day/12)

This puzzle was tough, and I spent a lot of time going back and forth on
different solutions. I tried recursion (which worked for part one but was
slow). I tried various sliding window techniques, but kept hitting edge
cases that threw off the counting.

What I've ended up with is a state machine approach, to count possible next
states based on the number of current states.

I start by transforming the numbers, e.g. `1,1,3` into a string repesenting
the series of damaged springs: `.#.#.###.`. This part is independent of the
actual record. It doesn't matter where the unknowns are, or how many good
springs come between the damaged ones. All this will represent are the indexes
of consecutive damaged springs that we need to keep track of. Each index into
this string will be a state that gets counted.

Then I iterate each character in the damage record, and keep count of which
indexes are possible. For example, a `#` or a `.` can match exactly the next
character in the state string, and a `?` matches anything. This can lead to
lots of invalid states, but that's ok. Only valid states will reach all the way
to the end of the state string, meaning that all the damaged springs fit
and all the literal `#` records are covered.

So once this iteration is complete, the final number of possible matching
states has been tallied under the ending index, and then it's a simple
matter of adding them all up.







