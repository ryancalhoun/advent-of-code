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
