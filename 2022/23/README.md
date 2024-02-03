Day 23: Unstable Diffusion

[Full info here](https://adventofcode.com/2022/day/23)

I didn't have a great plan for this. Just kinda hacked at it until it worked.

The only difficulties I had were those of my own making. For example, I had 
mixed up the order I had defined my directions, and tried to use a single index
to refer to two things which should have been the same. Not a great design.

The only note about performance is that is made a huge difference whether or
not to hash the current points during each round. Specifically, looking up all
the neighbors without hashing was really expensive.

Just looking up the points in a list:
```
PART=1 python3 app.py < full.txt

real    0m5.056s
user    0m5.046s
sys     0m0.010s
```

Wrapping the current points in a set for each round:
```
PART=1 python3 app.py < full.txt

real    0m0.094s
user    0m0.085s
sys     0m0.009s
```

For part two, even with the set lookup, running the required number of iterations
still took a bit of time:
```
PART=2 python3 app.py < full.txt

real    0m6.217s
user    0m6.186s
sys     0m0.030s
```

But, it got the answer, so I'm not going to fiddle with this one any further.
