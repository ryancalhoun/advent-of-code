# Day 20: Grove Positioning System

The key to this puzzle is first realizing that as numbers move around,
the index can be updated with a modulus operator. That way, it doesn't
matter how big the number is--it might wrap all the way around the list
a million times, but only end up moving one or two places.

Since the number gets removed before moving it, the modulus is taken with
`length(list)-1`.

The other wrinkle is that when a number lands at the front of the list,
it should be moved to the back.

I chose to implement my solution using two lists, one the original list
of numbers, the other a list of indexes. Like this:
```
numbers = [5,7,3,6]
indexes = [0,1,2,3]
```

I left the list of numbers alone, and swapped the order of the indexes.
That way, I can always iterate in the original order of numbers no matter
how many times the mix operation is run.
