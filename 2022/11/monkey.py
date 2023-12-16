from dataclasses import dataclass, field 
from typing import Callable
import re

@dataclass
class Monkey:
  items: list
  op: Callable[[int, int], int]
  div_by: int
  if_true: int
  if_false: int
  count: int = 0

def to_op(sym, b):
  if sym == '+':
    return lambda old : old + (old if b == 'old' else int(b))
  elif sym == '*':
    return lambda old : old * (old if b == 'old' else int(b))

def parse_monkey(f):
  line = f.readline()
  if not line:
    return None

  n = int(re.search(r'(\d+):', line).groups()[0])

  line = f.readline()
  items = [int(x) for x in re.findall(r'\d+', line)]

  line = f.readline()
  a, sym, b = re.search(r'(old) ([*+]) (old|\d+)', line).groups()
  op = to_op(sym, b)

  line = f.readline()
  div = int(re.search(r'(\d+)', line).groups()[0])

  line = f.readline()
  if_true = int(re.search(r'(\d+)', line).groups()[0])

  line = f.readline()
  if_false = int(re.search(r'(\d+)', line).groups()[0])

  f.readline()

  return Monkey(items, op, div, if_true, if_false)

def take_turn(m, manage, throw_to):
  while len(m.items) > 0:
    m.count += 1
    item = m.items.pop(0)
    w = manage(m.op(item))

    if w / m.div_by % 1 == 0:
      throw_to(m.if_true, w)
    else:
      throw_to(m.if_false, w)

