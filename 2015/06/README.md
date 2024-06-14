# Day 6: Probably a Fire Hazard

[Full info here](https://adventofcode.com/2015/day/6)

Languages:
* Perl
* Octave

For this puzzle, I used perl to convert the input from natural
language directions into Matlab/Octave source code. So I'm not
piping data into an Octave program, I'm actually piping in the
steps to be run to produce the result.

I feel like these two languages are actually the most perfectly
suited to this solution: Perl for transforming text and Octave
for performing fast vectorized operations.

It would have been more weird to take these two languages and
reverse their usage--to process the input with Octave and
manipulate the data with Perl. It's fine, they don't all have
to be weird on purpose.
