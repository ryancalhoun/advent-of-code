import sys
import os
import itertools
from journey import Journey
from valve import Valve

def read_tunnels(f):
  for line in f:
    a, b = line.rstrip().split(';')
    w = a.split(' ')
    v = w[1]
    r = int(w[4].split('=')[1])
    w = b.split(' ')
    t = [s.replace(',', '') for s in w[5:]]

    yield v, r, t

def set_pair_distances(g):
  for name in g:
    q = [name]
    while len(q) > 0:
      u = g[q.pop(0)]
      d = u - name

      for n in u.neighbors:
        v = g[n]

        if v.visit(name, d + 1):
          q.append(n)

def find_flow_paths(valves, time, start, journey=Journey()):

  journies = [journey]

  for v in valves:

    t = time - (v - start) - 1
    if t <= 0:
      continue

    if not v in journey:
      journies += find_flow_paths(valves, t, v.name, journey + v * t)

  return journies

def main():

  g = {}
  for name, rate, neighbors in read_tunnels(sys.stdin):
    g[name] = Valve(name, rate, neighbors)

  set_pair_distances(g)

  valves = [g[k] for k in g if g[k].rate > 0]

  if os.environ.get('PART') == '1':
    print(max(find_flow_paths(valves, 30, 'AA')))
  else:
    journies = find_flow_paths(valves, 26, 'AA')
    single_best = max(journies)
    partition = next(iter(single_best))

    a, b = [], []
    for j in journies:
      (a, b)[partition in j].append(j)

    best_pair = None

    for j1 in a:
      for j2 in b:
        if not j1 & j2:
          best_pair = max(j1 + j2, best_pair)

    print(best_pair)

if __name__ == '__main__':
  main()
