# Day 4: Repose Record

[Full info here](https://adventofcode.com/2018/day/4)

For this puzzle, I created a handful of classes to work together. The
LogEntry, the Guard, the Clock. Clock is just a 60-bucket counter.

With these objects filled, .NET provides several helpful collection
methods, Max and MaxBy for example, that make getting to the answer
fairly straightforward.

I was able to integrate a lambda with the Delegate pattern to DRY out
some code, which was fun.

My biggest hurdle is figuring out how to deal with nullable and non-nullable
types in a clean way.
