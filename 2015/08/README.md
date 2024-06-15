# Day 8: Matchsticks

[Full info here](https://adventofcode.com/2015/day/8)

Languages:
* Python
* Awk

The Python code opened an Awk script with pipes, streamed the
input contents through the pipes. and counted characters on
each side.

Parts one and two each had an Awk script, decode and encode. The
most challenging part of this process to debug was that I needed
to set `LANG=c` to get Awk to just print the byte without trying
to change the charset.
