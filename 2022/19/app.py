import re
import sys
import os
from timeline import Timeline

def blueprints():
  i = 1
  for line in sys.stdin:
    b = {}
    for r, c in re.findall(r'Each (\w+) robot costs ([^.]+).', line):
      t = {}
      for num, of in re.findall(r'(\d+) (\w+)', c):
        t[of] = int(num)
      b[r] = t
    yield i, b
    i += 1

total = 0
product = 1
minutes = 24

arbitrary_limits = {
  'ore': 8,
  'clay': 14,
  'obsidian': 18,
}

if os.environ.get('PART') == '2':
  minutes = 32
  arbitrary_limits['clay'] = 18
  arbitrary_limits['obsidian'] = 24

arbitrary_limits['geode'] = minutes

for i, b in blueprints():
  if i > 3 and os.environ.get('PART') == '2':
    break

  t = Timeline(b, minutes)

  q = [t]
  m = 0
  while len(q) > 0:
    p = q.pop(0)

    if p.t[-1].resources['geode'] > m:
      m = p.t[-1].resources['geode']

    for r in ['geode', 'obsidian', 'clay', 'ore']:
      if p.i > arbitrary_limits[r]:
        continue

      n = p.try_buy(r)
      if n:
        q.append(n)

  total += i * m
  product *= m

if os.environ.get('PART') == '2':
  print(product)
else:
  print(total)

