# Day 7: The Sum of Its Parts

[Full info here](https://adventofcode.com/2018/day/7)

This code is a bit messy. I have a few classes to help, such as encapsulating
the work queue's size, but it could benefit from additional refactoring that
I'm not going to do. There's just kind of a lot of code in the main.

I begin with a dictionary of `child` to `list-of-parent`. These lists are keeping
track of reasons the (child) work cannot be done. As work becomes done, I remove 
parents from each list, until I get to the last one. On removing the last parent,
the child is added to a queue.

The queue is sorted to keep alphabetically lower steps at the front.

As work becomes available, it is moved into a WorkQueue and labelled with the time
it will be completed (until the WorkQueue is full).

For part 1, the WorkQueue has a size of 1, and all items added at time `t` will
complete at `t+1`. This way, it functions serially and has no impact on the output
ordering.

For part 2, the WorkQueue has a size of 5 and items are completed at `t + 60 + <letter>`.
