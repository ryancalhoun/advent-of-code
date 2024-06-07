# Day 19: Aplenty

[Full info here](https://adventofcode.com/2023/day/19)

Part one of this puzzle was a simple state machine. I used map lookups with
the workflow name as the key.

To simplify the stopping condition, I added my Accepted and Rejected as if
there were each additional workflows. 

Then since the Accepted destination has been given all the accepted objects,
it's just a matter of iterating and adding.

Part two was fun. Especially in a language like Ruby which allows me to
override almost anything. I could have done something similar in C++ although
it would have taken additional wrapper classes.

Essentially, I created a shim around the objects I pass into the workflows,
and also around the list of objects to process. Then I kick off the chain
with a single set of default ranges, 1-4000, and run it through the same
system that already worked for part 1.

Any time I compare a range against a limit, I slice the range into a true
part and a false part. So if I start with 1-4000 and hit a rule that says
less than 1000, I update my range to 1-999 and make the rule evaluate as
true. At the same time, I append a new object which is a duplicate except
its range for this key is 1000-4000.

Each time a range could be true or false, I split the object so it can be
both. I stop processing once the objects stop splitting.

Then, to get the answer instead of adding sums, I'm adding the products of
range sizes.
