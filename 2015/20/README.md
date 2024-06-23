# Day 20: 20 Infinite Elves and Infinite Houses

[Full info here](https://adventofcode.com/2015/day/20)

Languages:
* Perl
* Java

My goal was to find a clever solution that was both space- and
memory-efficient. The direct approach would have been to allocate
a huge array to represent houses, and populate it by adding multiples
of each integer starting from 1. Here is what I did instead:

Any number can be represented by the product of its prime factors:
$$ n = a^x \cdot b^y \cdot c^z ...$$

In this formulation, the number $n$ is the product of prime numbers
$a$, $b$, and $c$, each raised to some power.

For example, the number 12 has factors 2, 3, 4, 6. Of these, only 2
and 3 are prime, so $12 = 2^2 \cdot 3^1 $.

Many very large numbers are the product of the first few primes. Many,
but not all. Such as $5000 = 2^3 \cdot 5^4$, which $4999=4999^1$.

However this is okay. Because of the way the target number is the
sum of primes, I am far more interested in those numbers which factor
into small primes. Especially those with a higher power on the lower
primes like 2 and 3. Numbers which are multiples of both 2 and 3 will
be visited way more often than numbers which are multiples of 11 and 13,
or 4999.

So I generate a sequence of possible exponents, like `[3, 2, 1]`. This 
would represent the first three primes: $2^3 \cdot 3^2 \cdot 5^1 = 160$.

I created a Perl app which launches a Java child process, with in and out
pipes open. The Perl code sends in sequences of exponents. The Java code
computes from the exponents the full list of factors, then returns the
sum. (For part two, it drops the factors less than 1/50 of the number).

The Perl code checks the factor sum against the target. For anything
exceeding the target amount, it keep the number as a potential answer.
The final answer is the minimum such number.

It works and is fast.

There is one catch. Generating all possible sets of 6 exponents is
very fast, but 7 slows down a lot, and 8 takes forever. My answer includes
a factor of 13 (the 6th prime) and so I can get the answer fast. I don't
need the next prime (17), but if I did the runtime would be substatially
slower. Also, it is hard to define a stopping condition that would work
in all cases.
