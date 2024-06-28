# Day 19: Not Enough Minerals

This solution is ugly and slow. I've tried so many ways to create a smart
solution, and have finally settled for one that just works.

I've included some arbitrary limits to speed things up, which happen to
work for my input, but would need to be adjusted (and make it slower,
probably) for a general case. These limits just say, e.g. "don't buy clay
after minute 12".

My approach was to begin with a single timeline of 24 (or 32) minutes,
with the ore initialized to each minute's number. This is the amount of
ore I'd have collected with just the initial robot.

I feed this timeline through the set of four resource types, and try to
buy each one, at whatever the next minute is I could afford it. 
