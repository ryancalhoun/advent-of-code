# Day 10: Elves Look, Elves Say

[Full info here](https://adventofcode.com/2015/day/10)

Languages:
* Python
* NodeJS

I constructed the see-say algorithm, given one element in the sequence from
STDIN, to write the next element to STDOUT. I did this part in Node, and the
process is very space-efficient. The only storage needed is a single counter,
a single character (for the previous character), and whatever incidental buffer
space is created by reading input. For each character I either increment the
counter if it is a repeat, or write to output if the repeat just ended.

In Python, I use low-level system calls to create a pipeline of N child Node
processes, with each STDOUT connected directly to the next's STDIN.

I fork-exec to create a Node process N times (e.g. 40 times) to create a single
long pipeline. I write a single input value to one end, and read the final
result from the other.

In this setup, a single item in this sequence never actually exists anywhere but
in the IO buffers of the series of child processes.

---

If my concern were to create the most speed-efficient implementation, I'd spend
more effort on skipping repeated parts of each sequence. There are identifiable
cycles which result in substantial overlap every 3 iterations.

Instead, I was more interested in forcing my solution to spread across two
languages, and the overall runtime was okay enough not to worry any further.

