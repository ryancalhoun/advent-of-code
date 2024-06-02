# Day 24: Lobby Layout

[Full info here](https://adventofcode.com/2020/day/24)

In order to represent a hex grid, I use the following convention for
(x,y) coordinates:

* Fully flush tiles directly `e` or `w` are an offset of $x\pm{2}$.
* Diagonally interlinked tiles are an offset of $x\pm{1}, y\pm{1}$.

So the hexagonal path is just making these increments for each direction,
starting from (0,0) each time.

Playing GO involves listing the six neighboring keys.

For parts one and two, once I've identified the key (as an "x,y" string)
I just store the tiles as a hash.
