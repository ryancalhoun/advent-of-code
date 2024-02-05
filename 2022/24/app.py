import sys
import os
from valley import Valley

def main():
  v = Valley()
  v.read(sys.stdin)

  t = v.cross(v.start(), v.end())

  if os.environ.get('PART') != '1':
    t = v.cross(v.end(), v.start(), t)
    t = v.cross(v.start(), v.end(), t)

  print(t)

if __name__ == '__main__':
  main()
