# Day 16: Proboscidea Volcanium

[Info here](https://adventofcode.com/2022/day/16)

This puzzle sets up a cyclic undirected graph.

Actually, it is given as a directed graph, but just happens to
include edges such that each edge going one direction has an exact
opposite going the other direction.

So what's important is not whether the edges are traversed, but
which valves have been opened. You can go past the same valve in
either direction as much as you like, but only open the valve
once.

My first pass through, I set each distance between each pair of
valves. For N valves, I run a Dijkstra variation N times, once per
valve.

So if there is a series like this:
```
AA @ 10 --> BB @ 0 --> CC @ 5
```
I don't need to actually visit BB from AA. I can skip directly from
AA to CC, knowing that I spent time 2 in the process.

Each valve I open costs one, plus the time it took to get there.

Now, there are many valves stuck at zero. By considering only the
nonzero valves, the problem space reduces from 58 to 15. For $n$-factorial
algorithms that can make a big difference.

I performed a recursive search to find the maximized path. It took
several attempts. My first few tries has me trying to find the max
starting from the end. The problem with that is by maximizing the end
first, you may have already used up the value which would be best placed
at the front.

The final solution was similar, but had to compute the value at the front
and pass it down. So the tail end of the path receives the summation of
every node that came before.

For part two, I thought a bit about writing a new traversal that would track
both paths simultaneously. Doing so may have ultimately been faster, but
getting the time differences right between the two paths would have been
tricky.

Instead I used the same traveral to collect all possible paths. The best pair
has the highest sum, while sharing no visited valves in common.o

The only optimization I made was to partition the full list of paths by a
high-value valve. Since I'm trying to find two paths with no valves in common,
I can choose one element from two smaller lists rather than two elements from
one big list.

All possible pairs where the order doesn't matter is half of $n$ choose 2:

$$
\frac{1}{2}\times{n \choose 2} = \frac{n(n-1)}{2}
$$

All possible pairs from two partitioned lists (where the order still doesn't
matter) is:

$$
f(m) = \frac{m(n-m)}{2}
$$

This has a best case where $m=1$ and $m=n-1$, and a worst case where $m=n/2$:

$$
\begin{aligned}
f(1, n-1) & = \frac{n-1}{2} \\
f(\frac{n}{2}) & = \frac{n^2}{4}
\end{aligned}
$$

So this is a decent improvement in theory, and in practice it improved the
overall runtime by almost half.



