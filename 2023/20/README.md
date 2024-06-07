# Day 20: Pulse Propagation

[Full info here](https://adventofcode.com/2023/day/20)

Part one was a pretty cool simulation of asynchronous communication. It was
easier to think of it as an actual network than it was to write
synchronous code to trigger all the callbacks. In Ruby, blocks helps organize
all the now/later behavior. This would have been interesting to code in
Javascript.

For part two, once I realized the ending condition wasn't going to happen
just by waiting, I started looking at various counters available. It turns
out that the four inputs to the last conjoiner did turn high one by one.

I made the assumption that the number of cycles between each high value 
would remain the same, so after I'd seen each of the four high values,
all it would take is to find the LCM between each of the cycle counts.

It would have been possible with less linear behavior too, much would take
a more complex solver to make the prediction.



