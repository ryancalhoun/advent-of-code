# Day 23: A Long Walk

[Full info here](https://adventofcode.com/2023/day/23)

## Part One

>Snow Island is pretty scenic, even without any snow; why not take a walk?

>There's a map of nearby hiking trails (your puzzle input) that indicates paths
(.), forest (#), and steep slopes (^, >, v, and <).

>For example:
```
#.#####################
#.......#########...###
#######.#########.#.###
###.....#.>.>.###.#.###
###v#####.#v#.###.#.###
###.>...#.#.#.....#...#
###v###.#.#.#########.#
###...#.#.#.......#...#
#####.#.#.#######.#.###
#.....#.#.#.......#...#
#.#####.#.#.#########v#
#.#...#...#...###...>.#
#.#.#v#######v###.###v#
#...#.>.#...>.>.#.###.#
#####v#.#.###v#.#.###.#
#.....#...#...#.#.#...#
#.#########.###.#.#.###
#...###...#...#...#.###
###.###.#.###v#####v###
#...#...#.#.>.>.#.>.###
#.###.###.#.###.#.#v###
#.....###...###...#...#
#####################.#
```

>You're currently on the single path tile in the top row; your goal is to reach
the single path tile in the bottom row. Because of all the mist from the
waterfall, the slopes are probably quite icy; if you step onto a slope tile,
your next step must be downhill (in the direction the arrow is pointing). To
make sure you have the most scenic hike possible, never step onto the same tile
twice. What is the longest hike you can take?

## Part Two

>As you reach the trailhead, you realize that the ground isn't as slippery as
you expected; you'll have no problem climbing up the steep slopes.

>Now, treat all slopes as if they were normal paths (.). You still want to make
sure you have the most scenic hike possible, so continue to ensure that you
never step onto the same tile twice. What is the longest hike you can take?

---

## Solution

This one was tough. I have no idea how to implement a longest-path algorithm
other than brute force, and have nowhere near an optimal solution.

For part 1:
```
$ time rake run PART=1 > /dev/null
ruby app.rb full.txt

real    0m0.211s
user    0m0.162s
sys     0m0.021s
```
And for part 2:
```
$ time rake run PART=2 > /dev/null
ruby app.rb full.txt

real    5m11.788s
user    5m11.720s
sys     0m0.043s
```

What I decided to do was a two-phase traveral of the map. First, I would identify
the start and end points of all path segments. Any time I got to a junction with
more than one way to go, I'd cut off the segment and start a new one for each
direction.

Then, taking all those segments, I could build a new reduced graph by joining
each of the overlapping start and end points. In this way, I reduced a
19,000-something node graph into a 30-something node graph.

So my brute force search for the longest path was done over a much smaller set
of nodes. Still very slow, but possible.

Maybe I'll return to this one in the future.
