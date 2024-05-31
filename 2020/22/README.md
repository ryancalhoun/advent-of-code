# Day 22: Crab Combat

[Full info here](https://adventofcode.com/2020/day/22)

The data structure for this was simple: just a pair of lists to
represent each hand of cards. Each round shifts from the front, then
pushes onto the back.

To abstract for parts one and two, I implemented the winner comparison
as a subroutine--initially just a value compare of the two cards. I also
added the _have I seen this hand before_ check unconditionally, since it
doesn't impact part one either way.

Part two's condition is described fully, but I had to re-read it very
carefully. I was initially copying both decks, and could not get the
recursion to end until I realized I needed to copy only the number of
cards for each player's drawn card value. If player one draws a three,
copy only the next three cards.
