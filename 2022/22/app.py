import sys
from board import Board
from path import Path

board = Board()
path = Path()

j = 0
for line in sys.stdin:
  i = 0
  for char in line:
    if char == '.':
      board.open(i, j)
    elif char == '#':
      board.wall(i, j)

    elif char in '0123456789RL':
      path.add(char)

    i += 1
  j += 1

p = board.first()
x = 0
for step in path.steps:
  p = board.move(p, step)
  x = 1000*(p[1]+1) + 4*(p[0]+1) + step[1]

print(x)
