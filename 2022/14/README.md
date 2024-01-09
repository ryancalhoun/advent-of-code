# Day 14: Regolith Reservoir

Ok, this is way overengineered for what it needs to be.

Could have gone way simpler and just tracked the occupied coordinates.

For part one, you can run
```
make part1 WINDOW=50
```
and watch the sand flow down blob by blob.

For part two, that simulation was too expensive to run, so instead I filled
below each horizontal surface with air bubbles in the inverse triangle that
would be left when sand piles join from each side. To get the answer I took
the total triangle size and subtract the cave surfaces and air bubbles.
