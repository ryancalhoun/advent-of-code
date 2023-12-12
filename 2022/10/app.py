import sys
import os

def read_instructions(f):
  cycle = 0
  x = 1
  for line in sys.stdin:
    inst, op = (line.rstrip().split(' ') + [0])[:2]

    cycle += 1
    yield cycle, x

    if inst == 'addx':
      cycle += 1
      yield cycle, x

      x += int(op)

total = 0
for cycle, x in read_instructions(sys.stdin):
  if (cycle-20) % 40 == 0:
    total += cycle * x

  if os.environ.get('PART') != '1':
    if (cycle-1) % 40 in range(x-1, x+2):
      print('#', end='')
    else:
      print('.', end='')
    if cycle % 40 == 0:
      print()

if os.environ.get('PART') == '1':
  print(total)
