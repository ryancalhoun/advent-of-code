# Day 20: Jurassic Jigsaw

[Full info here](https://adventofcode.com/2020/day/20)

In order to identify common edges, I compute a score for each edge of
each tile. That is, a 10-bit number where `#` is 1 and `.` is 0. Two for
each edge, forward and backward, to represent it being flipped.

Once I have 8 score values for each tile, I compare each tile against all
others. Two tiles which share an edge will have a score value in common.
Actually, they have two scores in common, since both tiles can be flipped
either way.

By counting tiles with common scores, I can identify which belong in the
corners. Tiles with a neighbor count of 8 (since I'm counting everything
twice) are in the middle. Tiles with 6 are non-corner edges. Tiles with
4 are corners. For part 1, all I'm looking for are corners.
