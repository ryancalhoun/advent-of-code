# Day 7: Camel Cards

[Full info here](https://adventofcode.com/2023/day/7)

## Part 1

>In Camel Cards, you get a list of hands, and your goal is to order
>them based on the strength of each hand. A hand consists of five cards
>labeled one of `A, K, Q, J, T, 9, 8, 7, 6, 5, 4, 3, or 2`. The relative
>strength of each card follows this order, where A is the highest and 2
>is the lowest.

>Every hand is exactly one type. From strongest to weakest, they are:
>- Five of a kind, where all five cards have the same label: AAAAA
>- Four of a kind, where four cards have the same label and one card has a different label: AA8AA
>- Full house, where three cards have the same label, and the remaining two cards share a different label: 23332
>- Three of a kind, where three cards have the same label, and the remaining two cards are each different from any other card in the hand: TTT98
>-Two pair, where two cards share one label, two other cards share a second label, and the remaining card has a third label: 23432
>-One pair, where two cards share one label, and the other three cards have a different label from the pair and each other: A23A4
>-High card, where all cards' labels are distinct: 23456

>To play Camel Cards, you are given a list of hands and their corresponding bid (your puzzle input). For example:
```
32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483
```

_(Full ordering rules on the original AoC page)_

>Now, you can determine the total winnings of this set of hands by adding
>up the result of multiplying each hand's bid with its rank >
>`(765 * 1 + 220 * 2 + 28 * 3 + 684 * 4 + 483 * 5)`. So the total winnings
>in this example are 6440.

Find the rank of every hand in your set. What are the total winnings?

## Part 2

>To make things a little more interesting, the Elf introduces one additional rule.
>Now, J cards are jokers - wildcards that can act like whatever card would make the
>hand the strongest type possible.

>To balance this, J cards are now the weakest individual cards, weaker even than 2.
>The other cards stay in the same order: `A, K, Q, T, 9, 8, 7, 6, 5, 4, 3, 2, J`.

---

## Solution

This puzzle is all about ~sorting~ ordering with custom rules. The distinction between
sorting and ordering is important to get the right answers.

The cards in each hand must be assigned an ordering value, so that `K` can be compared
with `Q` correctly, but the cards are not sorted into this order. The ordering of
cards only comes into play when comparing different hands.

Hand types (full house, two pair, etc) have an established ordering.

Hands are sorted first by type, then by cards. Cards are compared in the same order
they are given in the input. For this sorting to work, it is important that card ordering
and hand ordering work in the same direction. If a `K` has a higher numerical value
than a `2`, then a full house has to have a higher numerical value than two pair.

Once the sort order for hands is correct, finding the power multiplier for each bet is
straightforward.

For part two, the puzzle description of Jokers sounds like an optimization problem,
potentially trying each permutation of each card in each hand to find the maximum.
However, it is possible on paper to take a couple of shortcuts before starting on the
implementation.

First, for the purpose of determing the hand type, it doesn't matter what the cards
are. A `22233` is a full house, and so is a `KQQKK`. What I really want to know is
how many of how many types I have. Both these hands have a `2` of one value and `3` of
another, of course equalling `5` total cards.

Second, I don't need to consider a Joker being all values (or any value). Only what
group it should belong to.

For the hands `J2233` and `JQQKK`, when I remove the Joker there are `2` and `2` of
the remaining cards. The best hand will be a full house, no matter what. It doesn't
matter whether I use the Joker as a `2` or `3`, or a `Q` or `K`, the result will be
a full house.

For the hand `JJ345`, the best I can get is three of a kind, but it doesn't matter
whether I use a `3`, `4`, or `5`. For `J3345` I would treat the Joker as a `3` because
it already has the most occurrences.

In general, I always add all the Jokers to whichever group has the most members (or
any group if they are all of equal size, like `2` and `2` or `1`, `1`, `1`, and  `1`.
The way the numbers work out, this will always lead to the best possible hand.


