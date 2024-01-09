import sys
import os
import re

def dist(a, b):
  return abs(b[0] - a[0]) + abs(b[1] - a[1])

def overlap_x(a, y, d):
  dy = abs(a[1] - y)
  dx = d - dy
  if dx > 0:
    return (a[0] - dx, a[0] + dx)

def overlapping(sensors, y):
  for s in sensors:
    x = overlap_x(s, y, sensors[s])
    if x:
      yield x

def intersections(up, down):
  for u0, u1 in up:
    b1 = u0[1] + u0[0]
    for d0, d1 in down:
      b2 = d0[1] - d0[0]

      x = (b2 - b1) / -2
      y = (b2 + b1) / 2

      if d0[0] <= u1[0] and u0[0] <= d1[0]:
        yield int(x), int(y)

def get_covered_ranges(sensors, y):
  covered = sorted([c for c in overlapping(sensors, y)], key=lambda x: x[0])
  joined = []
  for c in covered:
    if len(joined) > 0 and c[0] <= joined[-1][1] + 1:
      joined[-1] = (joined[-1][0], max(joined[-1][1], c[1]))
    else:
      joined.append(c)
  return joined

sensors = {}

up = []
down = []

for line in sys.stdin:
  s, b = [(int(p[0]), int(p[1])) for p in re.findall(r'x=(-?\d+), y=(-?\d+)', line)]
  d = dist(s, b)
  sensors[s] = d

  down.append([(s[0], s[1] - d - 1), (s[0] + d + 1, s[1])])
  down.append([(s[0] - d - 1, s[1]), (s[0], s[1] + d + 1)])

  up.append([(s[0], s[1] + d + 1), (s[0] + d + 1, s[1])])
  up.append([(s[0] - d - 1, s[1]), (s[0], s[1] - d - 1)])

if os.environ.get('PART') == '1':
  print(sum([r[1] - r[0] for r in get_covered_ranges(sensors, int(os.environ.get('ROW')))]))
else:
  s = {}
  for x, y in intersections(up, down):
    if x >= 0 and x <= int(os.environ.get('BOUND')) and y >= 0 and y <= int(os.environ.get('BOUND')):
      s[y] = True

  for y in s:
    covered = get_covered_ranges(sensors, y)
    if len(covered) > 1:
      print(400000*(covered[0][1] + 1) + y)


