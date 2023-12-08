# Day 2: Rock Paper Scissors

## Part 1

>Appreciative of your help yesterday, one Elf gives you an encrypted strategy
guide (your puzzle input) that they say will be sure to help you win. "The
first column is what your opponent is going to play: A for Rock, B for Paper,
and C for Scissors. The second column--" Suddenly, the Elf is called away to
help with someone's tent.

>The second column, you reason, must be what you should play in response: X for
Rock, Y for Paper, and Z for Scissors. Winning every time would be suspicious,
so the responses must have been carefully chosen.

>The winner of the whole tournament is the player with the highest score. Your
total score is the sum of your scores for each round. The score for a single
round is the score for the shape you selected (1 for Rock, 2 for Paper, and 3
for Scissors) plus the score for the outcome of the round (0 if you lost, 3 if
the round was a draw, and 6 if you won).

>Since you can't be sure if the Elf is trying to help you or trick you, you
should calculate the score you would get if you were to follow the strategy
guide.

>For example, suppose you were given the following strategy guide:
```
A Y
B X
C Z
```

>In this example, if you were to follow the strategy guide, you would get a
total score of 15 (8 + 1 + 6).

>What would your total score be if everything goes exactly according to your
strategy guide?

## Part 2

>The Elf finishes helping with the tent and sneaks back over to you. "Anyway,
the second column says how the round needs to end: X means you need to lose, Y
means you need to end the round in a draw, and Z means you need to win. Good
luck!"

>Now that you're correctly decrypting the ultra top secret strategy guide, you
would get a total score of 12.

---

## Solution

This puzzle ended up being almost exclusively dictionary lookups. The codes,
the scoring, the what-beats-what, are all pre-defined as dictionaries.

For part 2, the behavior for how to win, lose, or draw against a given value
are defined in a dictionary.

And as a bonus, even though I had my dictionary for what-beats-what (given
the loser, look up the winner), it actually works in the other direction by
performing the lookup twice.
