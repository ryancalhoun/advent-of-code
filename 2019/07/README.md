# Day 7: Amplification Circuit

[Full info here](https://adventofcode.com/2019/day/7)

This was a bit more complex and required some refactoring from my previous
Day 5 int code. The most signifcant changes are in the way the input works.

So now instead of running from instruction 0 and expecting the input to be
there already, now I run until I get to an input and stop. When the input
is ready, I signal the program to continue from the same instruction.

I hooked the series of amplifiers together directly, so that one's output
immediately signals the next one's input. Effectively the first amplifier
will yield its processing until the last amplifier has paused, then each
amplifier resumes and pauses in reverse order, before the first amplifier
resumes and waits on the next input.

This would have worked really well with either threads or async callbacks,
but this serial implementation did manage to get the correct answers. The
only major implementation issue I had to work around was the stack depth
limit--I had to sever the direct tie between the last amp and the first in
the feedback loop, allow the call to terminate before making a new call in
a loop.
