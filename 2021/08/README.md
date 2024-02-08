# Day 8: Seven Segment Search

[Full info here](https://adventofcode.com/2021/day/8)

Finally, I've used C++ lambdas!

This puzzle presented a number of good opportunities to try out several language
features that, for one reason or another, I hadn't previously used. The auto
keyword for one. Lambdas for another. Also, various parts of the STL (like std::find\_if)
which require a predicate, which tend to need a lot of boilerplate before lambdas
were around. Definitely not least, foreach loops.

I feel so modern.

Ok, in terms of solution, I mostly ignored the puzzle's suggestion of determining
the mappings by process of elimination. Instead, I slurped the letters from all ten
input tokens into a single histogram. It turns out that if all ten digits are given
in the input, the individual display segments will be "on" a predictable number of
times:

* a: 8
* b: 6
* c: 8
* d: 7
* e: 4
* f: 9
* g: 7

The only disambiguation that needs to be done is between `a/c` and `d/g`. For this, I
look at the input number 4 (which has a unique number of segments, so it's easy to
find).

```
 ....
b    c
c    c
 dddd
.    f
.    f
 ....
```

The number four happens to contain `c` but not `a`, and `d` but not `g`. 

With the letter frequency and the scrambled token for 4, I can compute the reverse
mappings to de-scramble the output.


