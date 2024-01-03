import sys
import os

elev = []
start = ()
end = ()

for line in sys.stdin:

  row = [line[i] for i in range(len(line.rstrip()))]
  s = [i for i in range(len(row)) if row[i] == 'S']
  e = [i for i in range(len(row)) if row[i] == 'E']

  if len(s) > 0:
    row[s[0]] = 'a'
    start = (len(elev), s[0])
  if len(e):
    row[e[0]] = 'z'
    end = (len(elev), e[0])

  elev.append([ord(c) for c in row])

def neighbors(elev, p):
  if p[0] > 0:
    yield (p[0]-1, p[1])
  if p[0] < len(elev) - 1:
    yield (p[0]+1, p[1])
  if p[1] > 0:
    yield (p[0], p[1]-1)
  if p[1] < len(elev[p[0]]) - 1:
    yield (p[0], p[1]+1)

def shortest_path_lengths(elev, end):

  dist = {
    end: 0
  }

  q = [end]
  while len(q) > 0:
    p = q.pop(0)
    e = elev[p[0]][p[1]]

    for n in neighbors(elev, p):
      if elev[n[0]][n[1]] + 1 < e:
        continue

      if not dist.get(n) or dist.get(n) > dist[p] + 1:
        dist[n] = dist[p] + 1
        q.append(n)

  return dist

dist = shortest_path_lengths(elev, end)

if os.environ.get('PART') == '1':
  print(dist[start])
else:

  starts = []
  for i in range(len(elev)):
    for j in range(len(elev[i])):
      if elev[i][j] == ord('a') and dist.get((i, j)):
        starts.append((i, j))
  

  print(min([dist[s] for s in starts]))

