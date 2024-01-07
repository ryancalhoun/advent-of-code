import sys
import os
import time
from cave import Cave

cave = Cave(500, 0)
cave.parse_from(sys.stdin)

def pause():
  print(cave)
  time.sleep(0.01)
  
  pass

def nopause():
  pass

i = 0

while i < int(os.environ.get('START_AT') or 0):
  cave.drop_sand(nopause)
  i += 1

while cave.drop_sand(pause):
  i += 1 

print(cave)
print(i)
