import sys
import os
from monkey import parse_monkey, take_turn

monkies = []

while True:
  m = parse_monkey(sys.stdin)
  if not m:
    break
  monkies.append(m)

def round(manage):
  for m in monkies:
    take_turn(m, manage, lambda i, item : monkies[i].items.append(item))

if os.environ.get('PART') == '1':
  rounds = 20
  manage = lambda w : int(w/3)
else:
  mod = 1
  for m in monkies:
    mod *= m.div_by
  rounds = 10000
  manage = lambda w : w % mod

for i in range(0, rounds):
  round(manage)

a, b = sorted([m.count for m in monkies])[-2:]
print(a*b)

