# Day 21: Allergen Assessment

[Full info here](https://adventofcode.com/2020/day/21)

This puzzle was just a bit of fun playing with maps, then iterating
to identify unknowns by process of elimination.

First, a map of allergens to possible ingredients. For each allergen
we see, add the associated list of ingredients. But, if we've already
seen this allergen before, we can narrow the ingredient list down to
one already in the list--an intersection operation. Also...keep a running
tally of each ingredient seen.

Next, find an allergen with a single ingredient, and remove that ingredient
from all other allergens. Repeat this until each allergen has a single
possible ingredient.

Now the necessary data for both parts one and two is available.

Sum up the ingredient tally without the unsafe ingredients.

Sort the map of allergen-ingredients by key.
