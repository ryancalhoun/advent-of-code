# Day 17: No Such Thing as Too Much

[Full info here](https://adventofcode.com/2015/day/17)

Languages:
* NodeJS
* C++

I built a Node module in C++ using the v8 library and `node-gyp`. This modules
finds all the combinations (of any length) that sum to the target total. And, wow
was that C++ yucky. `v8::Value` is not the easiest class in the world for converting
data.

The Node app receives each valid combination and tallys the results for parts one
and two.
