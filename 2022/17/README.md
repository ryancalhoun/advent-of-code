# Day 17: Pyroclastic Flow

Modelling the rock shapes and movements for this puzzle was fun.

I kept the tower of rocks in a simple list, but sorted by the topmost
value. So the last element in the list has the highest top. That makes it
easy to drop in a new rock.

I started off checking each falling rock against all other rocks at each
point in time, which got expensive pretty quickly. This was easy to fix:

* Since each rock always starts higher than the rest, they don't need to
be checked for intersection until the bottom of the new rock is at the same
level at the top of the old rock. 
* Since a new rock is most likely to intersect the highest and stop, it makes
the most sense to check starting at the end of the list and breaking the
iteration once a match is found.

This was basic stuff, and worked fine for part one.

Part two was pretty obviously not an optimization problem. I was imagining the
twist would be rotating blocks, or a wider space. But, with the sheer number
of iterations to perform, no amount of optimization in the world would make
that possible.

Instead, it was an extrapolation problem. Since the sequence of rocks repeats
forever, and the sequence of jets repeats forever, eventually the tower will
start growing at a repeating and predictable rate.

So it becomes an issue of identifying the beginning and length of the sequence.
Once those are known, any future value can be predicted.

