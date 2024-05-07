# Day 6: Custom Customs

[Full info here](https://adventofcode.com/2020/day/6)

For part one of this puzzle, I kept a list of hashes. Each hash was
a count of the number of times each answer appears for a group.

To accommodate part two, I expanded the basic hash into a Group object.
This lets me couple the answer count for each group with the member
count.

By knowing the member count, I can trim the answer list down to those
that equal the member count. In other words, the answers that all members
of the group answered.
