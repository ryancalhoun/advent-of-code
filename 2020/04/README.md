# Day 4: Passport Processing

[Full info here](https://adventofcode.com/2020/day/4)

This was a fun puzzle, and a good way to remember more perl-isms. It's possible
that the parsing and validation could be a little cleaner with the passport
as an object, but not by all that much. It's simpler to just use plain hashes.

I had forgotten how simple it is to use anonymous subroutines, and implemeting
the rules was a good use-case.

For storage, I keep a list of hashes, one hash for each passport. In perl, this
seems the cleanest way to handle both the blank line and end-of-file. This way
I can be sure to call validate exactly once per passport, without needing special
end-of-input checking.
