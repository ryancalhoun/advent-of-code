# Day 4: Secure Container

[Full info here](https://adventofcode.com/2019/day/4)

Well, this solution is a fairly brute force recursion and count.

I have a little logic to ensure the digits in the array are never decreasing.
The outer recursion (or the outer loop(s), I guess) increment digits from
the front. So the most frequently incremented and reset digit would be the
last one.

The only thing that needs to differ from part one to two is checking for
repeated digits.
