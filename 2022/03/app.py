import string
import sys
import os

def count_objects(objs):
  h = {}
  for char in [objs[i] for i in range(len(objs))]:
    if char in string.ascii_uppercase:
      p = ord(char) - ord('A') + 27
    else:
      p = ord(char) - ord('a') + 1

    h[p] = h.get(p, 0) + 1
  return h

def dict_keys(d):
  return set(d.keys() if type(d) == dict else d)

def find_common(a, b):
  return dict_keys(a) & dict_keys(b)

def getlines(readline, n):
  while True:
    lines = [readline().rstrip() for i in range(n)]
    if not lines[0]:
      break
    yield lines

def get_common_priorities(readline, part):

  for lines in getlines(readline, 1 if part == 1 else 3):
    if part == 1:
      total = len(lines[0])

      first = count_objects(lines[0][0:int(total/2)])
      second = count_objects(lines[0][int(total/2):total])

      for p in find_common(first, second):
        yield p
    else:
      first, second, third = [count_objects(line) for line in lines]

      for p in find_common(first, find_common(second, third)):
        yield p

if __name__ == '__main__':
  common = []
  for p in get_common_priorities(sys.stdin.readline, part = int(os.environ.get('PART') or 0)):
    common.append(p)

  print(sum(common))

