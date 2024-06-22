# Day 21: RPG Simulator 20XX

[Full info here](https://adventofcode.com/2015/day/21)

Languages:
* Python
* C++

I created a Python module using the C-API, in C++, to represent
playing a game. The game object holds the Boss's values, and records
the outcome for each player's values.

The rest of the app in Python generates a list of all possible combinations
of items that might be bought, and checks the winner of a game playes with
those items.

Getting the C++ code to load correctly in Python was a slow start, mainly
because there is lots of documentation out there for Python 2 and Python 3,
and each set of documentation does not always distinguish which.
