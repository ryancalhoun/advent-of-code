import sys
import os

from cave import Cave
from jet import Jet
from shape import Shape

jet = Jet.parse(sys.stdin.readline())
shape = Shape()
cave = Cave(jet, shape)

if os.environ.get('PART') == '1':
  cave.drop(2022)
else:
  cave.drop(1000000000000)

print(cave.top())

