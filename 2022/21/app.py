import sys
import os

from monkey import Tree
from human import Unknown

def main():
  tree = Tree()
  for line in sys.stdin:
    tree.parse(line)

  if os.environ.get('PART') != '1':
    tree['root'].oper = lambda a, b : a == b
    tree['humn'].value = Unknown()

  print(tree['root'].evaluate())

if __name__ == '__main__':
  main()

