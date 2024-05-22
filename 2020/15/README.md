# Day 15: Rambunctious Recitation

[Full info here](https://adventofcode.com/2020/day/15)

Hmm, this one is slow, and I haven't come up with any good optimizations
yet. The pattern of numbers doesn't seem to repeat or follow any kind of
predictable cycle. Generating diffs of the last seen numbers requires
having seen them, so it doesn't appear possible to skip turns.

My strategy was to keep a hash of `{ number : turn }` where
`turn` is the turn before the last turn.

This works and scales linerarly.
