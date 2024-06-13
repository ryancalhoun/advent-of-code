# Day 1: No Time for a Taxicab

[Full info here](https://adventofcode.com/2016/day/1)

Since I'm working in Octave, this seemed like a good opportunity to take
advantage of vecorized code.

I keep a 2-vector of position and a direction angle. Any time I read an R
or L, I update the direction by 90 degrees.

I take my step as a 2-vector of `[0, distance]` as if I'm always going
north, but multiple by a rotation matrix, then add to my position.

For part two, I tried out `collection.Map`, which is something that I'm
going to have to experiment with for a while to really figure out the best
way to use it. For each step, I iterated along the direction one place at 
a time, since the crossing is any point along the path, not just at turns.
Maybe this would work better as a line intersection solution instead of
point mapping.
