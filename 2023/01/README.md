# Day 1: Trebuchet?!

[Full info here](https://adventofcode.com/2023/day/1)

## Part 1
> The newly-improved calibration document consists of lines of text;
> each line originally contained a specific calibration value that the Elves now need to recover.
> On each line, the calibration value can be found by combining the first digit and the last
> digit (in that order) to form a single two-digit number.

> For example:
```
1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet
```

## Part 2
> Your calculation isn't quite right. It looks like some of the digits are actually spelled out
> with letters: one, two, three, four, five, six, seven, eight, and nine also count as valid "digits".

> Equipped with this new information, you now need to find the real first and last digit on each line. For example:
```
two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen
```

---

## Solution

The parsing of the part one document is pretty straightforward using regexes. It's just matching single digits
using `/\d+/` and ignoring everything else.

The wrinkle in part two is two-fold. First, you obviously have to match the spelled-out digits as well. And
second, you have to account for overlapping words like `oneight` or `sevenine`. With regexes, this can be done
with a look-ahead match, such as `/(?=(\d|...))/`, which can find a match on the input without consuming the input.
