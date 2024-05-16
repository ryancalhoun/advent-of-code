# Day 12: Hot Springs

[Full info here](https://adventofcode.com/2023/day/12)

## Part 1

>In the giant field just outside, the springs are arranged into rows. For each
row, the condition records show every spring and whether it is operational (.)
or damaged (#). This is the part of the condition records that is itself
damaged; for some springs, it is simply unknown (?) whether the spring is
operational or damaged.

>However, the engineer that produced the condition records also duplicated some
of this information in a different format! After the list of springs for a
given row, the size of each contiguous group of damaged springs is listed in
the order those groups appear in the row. This list always accounts for every
damaged spring, and each number is the entire size of its contiguous group
(that is, groups are always separated by at least one operational spring: ####
would always be 4, never 2,2).

>So, condition records with no unknown spring conditions might look like this:
```
#.#.### 1,1,3
.#...#....###. 1,1,3
.#.###.#.###### 1,3,1,6
####.#...#... 4,1,1
#....######..#####. 1,6,5
.###.##....# 3,2,1
```

>However, the condition records are partially damaged; some of the springs'
conditions are actually unknown (?). For example:
```
???.### 1,1,3
.??..??...?##. 1,1,3
?#?#?#?#?#?#?#? 1,3,1,6
????.#...#... 4,1,1
????.######..#####. 1,6,5
?###???????? 3,2,1
```

>Equipped with this information, it is your job to figure out how many different
arrangements of operational and broken springs fit the given criteria in each
row.

## Part 2

>As you look out at the field of springs, you feel like there are way more
springs than the condition records list. When you examine the records, you
discover that they were actually folded up this whole time!

Unfold the records by repeating each line 5 times.

---

## Solution

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







