import sys
import os
import time
from cave import Cave


def run_sim(cave, start_at):

  def pause():
    print(cave)
    time.sleep(0.01)

  def nopause():
    pass

  i = 0
  while i < start_at and cave.drop_sand(nopause):
    i += 1

  while cave.drop_sand(w > 0 and pause or nopause):
    i += 1 

  return i

def infinite_floor(cave):
  cave.add_bubbles()
  return cave.count_infinite_triangle()

if __name__ == '__main__':
  cave = Cave(500, 0)
  cave.parse_from(sys.stdin)

  try:
    total = 0
    if os.environ.get('PART') == '1':
      w = int(os.environ.get('WINDOW') or 0)
      if w > 0:
        cave.set_window(w)

      total = run_sim(cave, int(os.environ.get('START_AT') or 0))
    else:
      total = infinite_floor(cave)

    cave.set_window(-1)
    print(cave)

    print(f'Total sand = {total}')

  except KeyboardInterrupt:
    print('stopped')
    exit()

