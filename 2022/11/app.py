import sys
import os
import re
from dataclasses import dataclass, field 
from typing import Callable

@dataclass
class Monkey:
  items: list
  op: Callable[[int, int], int]
  div_by: int
  if_true: int
  if_false: int
  count: int = 0


monkies = []

def to_op(sym, b):
  if sym == '+':
    return lambda old : old + (old if b == 'old' else int(b))
  elif sym == '*':
    return lambda old : old * (old if b == 'old' else int(b))

while True:
  line = sys.stdin.readline()
  n = int(re.search(r'(\d+):', line).groups()[0])

  line = sys.stdin.readline()
  items = [int(x) for x in re.findall(r'\d+', line)]

  line = sys.stdin.readline()
  a, sym, b = re.search(r'(old) ([*+]) (old|\d+)', line).groups()
  op = to_op(sym, b)

  line = sys.stdin.readline()
  div = int(re.search(r'(\d+)', line).groups()[0])

  line = sys.stdin.readline()
  if_true = int(re.search(r'(\d+)', line).groups()[0])

  line = sys.stdin.readline()
  if_false = int(re.search(r'(\d+)', line).groups()[0])

  monkies.append(Monkey(items, op, div, if_true, if_false))

  line = sys.stdin.readline()
  if not line:
    break

def take_turn(m, manage, throw_to):
  while len(m.items) > 0:
    m.count += 1
    item = m.items.pop(0)
    w = manage(m.op(item))

    if w / m.div_by % 1 == 0:
      throw_to(m.if_true, w)
    else:
      throw_to(m.if_false, w)

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

