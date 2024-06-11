# Day 9: Marble Mania

[Full info here](https://adventofcode.com/2018/day/9)

I tried to come up with a pattern for the marble placement that
I could extrapolate the game results without actually iterating through
each round.

I ended up just implemented a circular linked list, and the set of game
rules exactly as they are described. It worked fine and was plenty fast
enough.

For data, I keep the marbles in a linked list, the current marked by a
current list position. I keep the scores in an array with a bucket for
each player.

