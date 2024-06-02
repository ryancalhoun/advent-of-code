# Day 19: Monster Messages

[Full info here](https://adventofcode.com/2020/day/19)

For part one, I just store the rules as they are given, and perform
a recursive search to match against each rule.

For part two, I add the two alternate paths that include loops as
directed. The main trick here is that you can't just look for the best
or longest match at each recursive level. Because rules like 8 and 11
both begin with multiple repetitions of rule 42, matching the longest
possible rule 8 will mean the following rule 11 can never be matched.

Instead, I keep a running list of matched indexes, and record all
matched lengths from each index. This potentially growing list of
indexes gets trimmed each time the recursion hits a literal "a" or "b"
by rejecting all the previously possible matches so far that don't match
the concrete rule at the current index.
