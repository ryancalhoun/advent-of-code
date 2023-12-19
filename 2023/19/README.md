# Day 19: Aplenty

[Full info here](https://adventofcode.com/2023/day/19)

## Part 1

>As you reach the bottom of the relentless avalanche of machine parts, you
discover that they're already forming a formidable heap. Don't worry, though -
a group of Elves is already here organizing the parts, and they have a system.

>To start, each part is rated in each of four categories:
```
x: Extremely cool looking
m: Musical (it makes a noise when you hit it)
a: Aerodynamic
s: Shiny
```

>Then, each part is sent through a series of workflows that will ultimately
accept or reject the part.

>Consider the workflow ex{x>10:one,m<20:two,a>30:R,A}. This workflow is named ex
and contains four rules. If workflow ex were considering a specific part, it
would perform the following steps in order:

>- Rule "x>10:one": If the part's x is more than 10, send the part to the workflow named one.
>- Rule "m<20:two": Otherwise, if the part's m is less than 20, send the part to the workflow named two.
>- Rule "a>30:R": Otherwise, if the part's a is more than 30, the part is immediately rejected (R).
>- Rule "A": Otherwise, because no other rules matched the part, the part is immediately accepted (A).

>For example:
```
px{a<2006:qkq,m>2090:A,rfg}
pv{a>1716:R,A}
lnx{m>1548:A,A}
rfg{s<537:gd,x>2440:R,A}
qs{s>3448:A,lnx}
qkq{x<1416:A,crn}
crn{x>2662:A,R}
in{s<1351:px,qqz}
qqz{s>2770:qs,m<1801:hdj,R}
gd{a>3333:R,R}
hdj{m>838:A,pv}

{x=787,m=2655,a=1222,s=2876}
{x=1679,m=44,a=2067,s=496}
{x=2036,m=264,a=79,s=2244}
{x=2461,m=1339,a=466,s=291}
{x=2127,m=1623,a=2188,s=1013}
```

>Sort through all of the parts you've been given; what do you get if you add
together all of the rating numbers for all of the parts that ultimately get
accepted?

## Part 2

Each of the four ratings (x, m, a, s) can have an integer value ranging from a
minimum of 1 to a maximum of 4000. Of all possible distinct combinations of
ratings, your job is to figure out which ones will be accepted.

In the above example, there are 167409079868000 distinct combinations of
ratings that will be accepted.

---

## Solution

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
