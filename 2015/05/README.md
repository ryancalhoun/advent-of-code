# Day 5: Doesn't He Have Intern-Elves For This?

[Full info here](https://adventofcode.com/2015/day/5)

Languages:
* C# .NET
* C

I built this solution with PInvoke. I created the rules to scan
a string in C code, one copy for part one and the other for
part two. I built a copy of the shared library for each part
under separate paths.

The C# code loaded and called the library's rule function, and
the only difference for parts one and two is which copy of the
library it loaded.
