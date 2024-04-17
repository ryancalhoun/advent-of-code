# Day 21: Dirac Dice

[Full info here](https://adventofcode.com/2021/day/21)

This puzzle consists of two players, each on their own board. It's important
that player one and player two never directly interact with each other on the
board--they might both occupy the same space for a round and it has no effect
on the outcome.

In order to accomodate part 2, I've kept track of each player as a map of `position`
to `score` to `count`. But for part 1, there will only be a single instance,
i.e. one position with a count of 1, and all others with a count of 0.

If a player starts a round with `{2 : {10: 1}}` and rolls a 1, the player will end
with `{3: {13: 1}}`. That is, move to space 3, add 3 to the score.

For part 2, by performing multiple rolls "at the same time", I begin counting multiple
copies of each player. So if a player starts with `{2 : {10: 1}}` and rolls both a
1 and a 2, that player ends with `{3: {13: 1}, 4: {14: 1}}`. If instead the player rolls
a 2 twice, it would be `{4: {14: 2}}`. This structure can represent any number of
player copies rolling any combination of rolls.

Each round, player 1 will roll a total of 27 combinations. Some of those might result
in a win. But also, player 2's total games will be multiplied by 27. Then, player 2 rolls
27 of their own combinations, and so on.

So long as the groupings of players into 10 positions remains fixed, the data and
computational time don't run out of control. In fact, the only real constraint is the
max value of a 64-bit number.


