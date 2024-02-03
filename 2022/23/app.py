import sys
import os

def empty(elves):
  xmin = min(e[0] for e in elves)
  xmax = max(e[0] for e in elves)
  ymin = min(e[1] for e in elves)
  ymax = max(e[1] for e in elves)

  return (xmax - xmin + 1) * (ymax - ymin + 1) - len(elves)

def run_round(r, elves):
  n  = lambda p : (p[0],   p[1]-1)
  s  = lambda p : (p[0],   p[1]+1)
  w  = lambda p : (p[0]-1, p[1])
  e  = lambda p : (p[0]+1, p[1])
  nw = lambda p : (p[0]-1, p[1]-1)
  ne = lambda p : (p[0]+1, p[1]-1)
  sw = lambda p : (p[0]-1, p[1]+1)
  se = lambda p : (p[0]+1, p[1]+1)

  directions = [
    (0, 4, 5), # n, nw, ne
    (1, 6, 7), # s, sw, se
    (2, 4, 6), # w, nw, sw
    (3, 5, 7), # e, ne, se
  ]

  current = set(elves)
  proposals = {}

  moved = 0

  for i in range(len(elves)):
    neighbors = [d(elves[i]) in current for d in [n, s, w, e, nw, ne, sw, se]]
    if not any(neighbors):
      continue

    for d in range(len(directions)):
      g = (d+r) % len(directions)
      if not any([neighbors[n] for n in directions[g]]):
        z = [n, s, w, e][g](elves[i])
        if not z in proposals:
          proposals[z] = []
        proposals[z].append(i)
        break
  
  for x in proposals:
    if len(proposals[x]) == 1:
      elves[proposals[x][0]] = x
      moved += 1

  return moved > 0

def main():
  elves = []
  y = 0
  for line in sys.stdin:
    x = 0
    for char in line:
      if char == '#':
        elves.append((x,y))
      x += 1
    y += 1

  if os.environ.get('PART') == '1':
    for i in range(10):
      run_round(i, elves)

    print(empty(elves))

  else:
    n = 0
    while run_round(n, elves):
      n += 1 

    print(n+1)

if __name__ == '__main__':
  main()
