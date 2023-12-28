import sys
import math

sys.setrecursionlimit(2000)

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

def shortest_path(elev, end, path, visited):
  p = path[-1]
  if p == end:
    print(f"Found end")
    return 0

  e = elev[p[0]][p[1]]

  found = []

  to_try = [n for n in neighbors(elev, p)]
  to_try.sort(key=lambda d : math.sqrt((d[0]-end[0])**2 + (d[1]-end[1])**2))

  for n in to_try:

    if n in visited:
      d = visited[n]
      if not d:
        continue
      print(f"({p} : Found visited route {d+1} from{n}")
      found.append(d + 1)

    else:
      if elev[n[0]][n[1]] <= e+1 and n not in path:
        path.append(n)

        s = shortest_path(elev, end, path, visited)
        print(f"{p} : path through {n} - {s}")
        if type(s) == int:
          found.append(s + 1)

        path.pop()

  if len(found) == 0:
    visited[p] = None
    return None

  shortest = min(found)
  visited[p] = shortest

  return shortest

print(shortest_path(elev, end, [start], {}))
