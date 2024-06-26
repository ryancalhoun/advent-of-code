#!/usr/bin/env python3

from subset import Subset
import sys
import os

numbers = []
for num in sys.stdin:
  numbers.append(int(num))

s = Subset(numbers)
parts = os.environ.get("PART") == "1" and 3 or 4
target = sum(numbers) // parts

if s.sum_to(target):
  for b in s.each(target):
    print(str.join(' ', (str(x) for x in b)))
