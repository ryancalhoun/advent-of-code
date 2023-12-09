import sys
import os
import grid

g = []

for line in sys.stdin:
  row = [int(line[j]) for j in range(len(line.rstrip()))]
  g.append(row)

result = 0
part = os.environ.get('PART')

for top, bottom, left, right in grid.visit(g, inclusive=part != '1'):
  if part == '1':
    if left[0] == left[1] or right[0] == right[1] or top[0] == top[1] or bottom[0] == bottom[1]:
      result += 1
  else:
    s = top[0] * bottom[0] * left[0] * right[0]
    if s > result:
      result = s

print(result)

