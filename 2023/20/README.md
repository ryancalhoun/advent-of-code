# Day 20: Pulse Propagation

[Full info here](https://adventofcode.com/2023/day/20)

## Part 1

>Modules communicate using pulses. Each pulse is either a high pulse or a low
pulse. When a module sends a pulse, it sends that type of pulse to each module
in its list of destination modules.

>There are several different types of modules:

* Flip-flop
* Conjunction
* Broadcast
* Output
* Button

>After pushing the button, you must wait until all pulses have been delivered
and fully handled before pushing it again. Never push the button if modules are
still processing pulses.

>Pulses are always processed in the order they are sent. So, if a pulse is sent
to modules a, b, and c, and then module a processes its pulse and sends more
pulses, the pulses sent to modules b and c would have to be handled first.

>The module configuration (your puzzle input) lists each module. The name of the
module is preceded by a symbol identifying its type, if any. The name is then
followed by an arrow and a list of its destination modules. For example:
```
broadcaster -> a, b, c
%a -> b
%b -> c
%c -> inv
&inv -> a
```

>To get the cables warmed up, the Elves have pushed the button 1000 times. How
many pulses got sent as a result (including the pulses sent by the button
itself)?

>In the first example, the same thing happens every time the button is pushed: 8
low pulses and 4 high pulses are sent. So, after pushing the button 1000 times,
8000 low pulses and 4000 high pulses are sent. Multiplying these together gives 32000000.

## Part 2

>The final machine responsible for moving the sand down to Island Island has a
module attached named rx. The machine turns on when a single low pulse is sent
to rx.

>Reset all modules to their default states. Waiting for all pulses to be fully
handled after each button press, what is the fewest number of button presses
required to deliver a single low pulse to the module named rx?

---

## Solution

Part one was a pretty cool simulation of asynchronous communication. It was
actually easier to think of it as an actual network than it was to write
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



