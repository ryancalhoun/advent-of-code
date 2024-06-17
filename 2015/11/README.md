# Day 11: Corporate Policy

[Full info here](https://adventofcode.com/2015/day/11)

Languages:
* Java
* Bash

I wrote the password increment logic as a Bash script. Whatever password
the script reads, it writes out the next one.

All the password rules get enforced in Java. The Java app takes whatever
password is written by the script, and checks if it's valid.

It is a hilariously inefficient approach, taking more than 7 minutes for
part one and 26 minutes for part two.
