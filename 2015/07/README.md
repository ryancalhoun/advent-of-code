# Day 7: Some Assembly Required

[Full info here](https://adventofcode.com/2015/day/7)

Languages:
* C++
* Java

I went wild with the JNI for this solution. I built a fairly simple
Java class that could evaluate an expression given as a string
array. Each element might be a number or an operation. It throws if
given a variable name.

The C++ code builds the diagram as a map of string to list. The list
is the expression given to the Java code. I also keep a map of string
to value, for each value that the Java code returns without error.

On each iteration, I replace unknowns with knowns, until the map of
signal values is completely filled.
