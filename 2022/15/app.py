import sys
import os
import re
import manhattan
import cartesian
import covering

def covered(sensors, y):
  c = []
  for s in sensors:
    x = manhattan.overlap_x(s, sensors[s], y)
    if x:
      c.append(x)
  return covering.reduced(c)

def main():
  sensors = {}

  edges = []

  for line in sys.stdin:
    s, b = [(int(p[0]), int(p[1])) for p in re.findall(r'x=(-?\d+), y=(-?\d+)', line)]
    d = manhattan.dist(s, b)
    sensors[s] = d

    u = d + 1
    edges.append([(s[0], s[1] - u), (s[0] + u, s[1])])
    edges.append([(s[0] - u, s[1]), (s[0], s[1] + u)])

    edges.append([(s[0], s[1] + u), (s[0] + u, s[1])])
    edges.append([(s[0] - u, s[1]), (s[0], s[1] - u)])

  if os.environ.get('PART') == '1':
    print(sum([r[1] - r[0] for r in covered(sensors, int(os.environ.get('ROW')))]))
  else:
    s = {}
    for x, y in cartesian.intersections(edges):
      if x >= 0 and x <= int(os.environ.get('BOUND')) and y >= 0 and y <= int(os.environ.get('BOUND')):
        s[y] = True

    for y in s:
      c = covered(sensors, y)
      if len(c) > 1:
        print(400000*(c[0][1] + 1) + y)

if __name__ == '__main__':
  main()
