# Day 3: Rucksack Reorganization

[Full info here](https://adventofcode.com/2022/day/3)

## Part 1

>The list of items for each rucksack is given as characters all on a single
line. A given rucksack always has the same number of items in each of its two
compartments, so the first half of the characters represent items in the first
compartment, while the second half of the characters represent items in the
second compartment.

>For example, suppose you have the following list of contents from six
rucksacks:
```
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
```

>To help prioritize item rearrangement, every item type can be converted to a
priority:
>-Lowercase item types a through z have priorities 1 through 26.
>-Uppercase item types A through Z have priorities 27 through 52.
In the above example, the priority of the item type that appears in both compartments of each rucksack is 16 (p), 38 (L), 42 (P), 22 (v), 20 (t), and 19 (s); the sum of these is 157.

## Part 2

>Every set of three lines in your list corresponds to a single group, but each
group can have a different badge item type. So, in the above example, the first
group's rucksacks are the first three lines:
```
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
```

>And the second group's rucksacks are the next three lines:
```
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
```

>In the first group, the only item type that appears in all three rucksacks is
lowercase r; this must be their badges. In the second group, their badge item
type must be Z.

---

## Solution

This puzzle comes down to finding set intersections between various groups
of keys.

I don't actually store the item code anywhere, because it isn't needed for
anything. I just convert it straight away to the priority, and make all the
comparisons that way.

For part one, each line is a group, and each set is half the line.

For part two, every three lines is a group, and each set is the whole line.

Python generators help with the code organization quite a bit.


