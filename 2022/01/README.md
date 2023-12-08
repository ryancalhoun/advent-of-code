# Day 1: Calorie Counting

[Full info here](https://adventofcode.com/2022/day/1)

## Part 1

The jungle must be too overgrown and difficult to navigate in vehicles or access
from the air; the Elves' expedition traditionally goes on foot. As your boats
approach land, the Elves begin taking inventory of their supplies. One important
consideration is food - in particular, the number of Calories each Elf is
carrying (your puzzle input).

>The Elves take turns writing down the number of Calories contained by the
various meals, snacks, rations, etc. that they've brought with them, one item
per line. Each Elf separates their own inventory from the previous Elf's
inventory (if any) by a blank line.

>For example, suppose the Elves finish writing their items' Calories and end up
with the following list:
```
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000
```
>This list represents the Calories of the food carried by five Elves:
- The first Elf is carrying food with 1000, 2000, and 3000 Calories, a total of 6000 Calories.
- The second Elf is carrying one food item with 4000 Calories.
- The third Elf is carrying food with 5000 and 6000 Calories, a total of 11000 Calories.
- The fourth Elf is carrying food with 7000, 8000, and 9000 Calories, a total of 24000 Calories.
- The fifth Elf is carrying one food item with 10000 Calories.

>Find the Elf carrying the most Calories. How many total Calories is that Elf
carrying?

## Part 2

>Find the top three Elves carrying the most Calories. How many Calories are
>those Elves carrying in total?

---

## Solution

I chose to implement this using a list of lists. Technically, a list of hashes of lists. A list
of elves each storing a list of calories, among other things (though nothing else was necessary).

It turned out not to be necessary. A minimal implementation would only need an accumulator for the
current sum, and a variable to hold the current max (for part two, a list of three, potentially).

But, I do prefer the flexibility the results from building the data structures to mirror the data,
and choosing how to process it later.
