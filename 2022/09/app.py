import sys
import math
import os

if os.environ.get('PART') == '1':
  length = 2
else:
  length = 10
rope_x = [0] * length
rope_y = [0] * length

visited = {}

for line in sys.stdin:
  d, n = line.rstrip().split(' ')

  for i in range(int(n)):
    if d == 'L':
      rope_x[0] -= 1
    elif d == 'R':
      rope_x[0] += 1
    elif d == 'U':
      rope_y[0] += 1
    elif d == 'D':
      rope_y[0] -= 1

    for j in range(1, len(rope_x)):
      dx = rope_x[j-1] - rope_x[j]
      dy = rope_y[j-1] - rope_y[j]

      if(abs(dx) == 2):
        rope_x[j] += int(dx/2)
        if(abs(dy) == 2):
          rope_y[j] += int(dy/2)
        else:
          rope_y[j] += dy
      elif(abs(dy) == 2):
        rope_y[j] += int(dy/2)
        if(abs(dx) == 2):
          rope_x[j] += int(dx/2)
        else:
          rope_x[j] += dx

    visited[(rope_x[-1], rope_y[-1])] = True

print(len(visited))
