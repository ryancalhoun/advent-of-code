# Day 18: Like a GIF For Your Yard

[Full info here](https://adventofcode.com/2015/day/18)

Languages:
* C# .NET
* NodeJS (Express)

I built the game of life logic into a node app, which reads a JSON
grid in a POST body, plays one round, and returns the next grid.

The .NET app starts the Node server, reads the input into a 2-d list,
then repeatedly POSTs it to get each updated state.

This made it easy to implement part two, since I already had a copy
of the grid at each state. I just had to set the corners to ON before
(and once after) each POST.
