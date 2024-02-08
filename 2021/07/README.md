# Day 7: The Treachery of Whales

[Full info here](https://adventofcode.com/2021/day/7)

This was a fun mix of templates and function pointers and STL accumulators.

I modeled each crab as a position with the ability to give the distance to another
position. It was simple enough I could have just embedded that in the cost
calculation, but this was fine.

I compute the cost via a functor object with an accumulator. For each position,
compute the cost for each crab, and return the sum. One implementation for part
one, a second for part two.

To find the best, I simply iterate starting from zero until the total cost hits
its lowest value. I made the initial assumption that this problem would produce
only a single global minimum, no local minima. Not necessarily parabolic, but
a curve that increases to infinity in both directions from a single point.

So, keep going while the total cost is decreasing. Stop once it begins to increase.
The search area is small, since it must be between the mix and max positions.

I may have been able to improve the minimization with a binary search pattern,
but what I ended up with works well enough.
