# Day 4: Scratchcards

[Full info here](https://adventofcode.com/2023/day/4)

## Part 1
>The Elf leads you over to the pile of colorful cards. There, you discover dozens of scratchcards,
>all with their opaque covering already scratched off. Picking one up, it looks like each card has
>two lists of numbers separated by a vertical bar (|): a list of winning numbers and then a list of
>numbers you have. You organize the information into a table (your puzzle input).

>As far as the Elf has been able to figure out, you have to figure out which of the numbers you have
>appear in the list of winning numbers. The first match makes the card worth one point and each match
>after the first doubles the point value of that card.

>For example:
```
Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
```
>In the above example, card 1 has five winning numbers (41, 48, 83, 86, and 17) and eight numbers you
>have (83, 86, 6, 31, 17, 9, 48, and 53). Of the numbers you have, four of them (48, 83, 17, and 86) are
>winning numbers! That means card 1 is worth 8 points (1 for the first match, then doubled three times
>for each of the three matches after the first).

## Part 2
>There's no such thing as "points". Instead, scratchcards only cause you to win more scratchcards equal
>to the number of winning numbers you have.

>Specifically, you win copies of the scratchcards below the winning card equal to the number of matches.
>So, if card 10 were to have 5 matching numbers, you would win one copy each of cards 11, 12, 13, 14, and 15.

>Copies of scratchcards are scored like normal scratchcards and have the same card number as the card they
>copied. So, if you win a copy of card 10 and it has 5 matching numbers, it would then win a copy of the
>same cards that the original card 10 won: cards 11, 12, 13, 14, and 15. This process repeats until none of
>the copies cause you to win any more cards. (Cards will never make you copy a card past the end of the table.)

---

## Solution

The parsing is pretty simple for this, since the only ordering that matters is before or after the `|`.
There is no need to compare numbers within sets or across lines. Both parts requiring couting matches,
which is essentially counting a set intersection.

For part two, I use a hash to count copies of a card before actually getting to that card. Then, when I
arrive at a card, I check the number of copies I already have from previous rounds, and use that as a
multiplier.
