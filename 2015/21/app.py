#!/usr/bin/env python3

import sys
import os
import game
from shop import Shop

boss = {}
for line in sys.stdin:
  k,v = line.split(':')
  boss[k] = int(v)
g = game.Game(boss['Hit Points'], boss['Damage'], boss['Armor'])

shop = Shop();

def optimal(seq, start, fn):
  n = None
  for (cost,damage,armor) in seq:
    if n and fn(cost, n):
      continue
    if fn(g.play(start, damage, armor), 0):
      n = cost
  return n

fn = os.environ.get('PART') == '1' and \
  (lambda a,b : a > b) or \
  (lambda a,b : a < b)

start = int(os.environ.get('START') or 100)

print(optimal(shop.arrangements(), start, fn))

