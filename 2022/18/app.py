import sys
import os

def count(decomposed, remove_interior=False):
  adjacent = 0
  obscurred = {}

  for i in range(len(decomposed)):
    for p, a, b in each_gap(decomposed[i]):
      if a + 1 == b:
        adjacent += 1
      else:
        for v in range(a+1, b):
          q = tuple(list(p[0:i]) + [v] + list(p[i:]))
          obscurred[q] = obscurred.get(q, 0) + 1

  if remove_interior:
    interior = count(decompose(enclosed(obscurred)))
  else:
    interior = 0

  cubes = sum(len(c) for c in decomposed[0].values())
  return cubes*6 - adjacent*2 - interior

def each_gap(dim):
  for p in dim:
    l = sorted(dim[p])
    for a, b in zip(l, l[1:]):
      yield p, a, b

def enclosed(cubes):
  for p, d in cubes.items():
    if d == 3:
      if not any(filter(lambda x: x and x != 3, (cubes.get(n) for n in neighbors(p)))):
        yield p

def neighbors(p):
  for i in range(len(p)):
    yield tuple(list(p[0:i]) + [p[i]+1] + list(p[i+1:]))
    yield tuple(list(p[0:i]) + [p[i]-1] + list(p[i+1:]))

def decompose(cubes):
  pts = [{}, {}, {}]
  for p in cubes:
    idx = list(range(len(p)))
    for a in idx:
      b, c = [p[i] for i in idx if a != i]
      l = pts[a]
      if not (b, c) in l:
        l[(b, c)] = []
      l[(b, c)].append(p[a])

  return pts

def read_cubes(f):
  for line in f:
    yield [int(c) for c in line.split(',')]

if __name__ == '__main__':
  print(count(decompose(read_cubes(sys.stdin)), os.environ.get('PART') != '1'))

