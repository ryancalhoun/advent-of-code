# Day 24: It Hangs in the Balance

[Full info here](https://adventofcode.com/2015/day/24)

Languages:
* Python
* C# .NET

I found possible subsets in Python, and piped them to C# to handle finding
the min.

My approach was to find subsets that would sum to 1/3 (or 1/4) the total. I
didn't bother finding the remaining groups. There are many combinations that
will be invalid, but my assumption was that since we are looking for the 
smallest such subset, the remaining numbers would balance without me needing
to actually identify the correct partitioning.

