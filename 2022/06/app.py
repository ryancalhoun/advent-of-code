import sys
import os

buf = []
i = 0

n = 4 if os.environ.get('PART') == '1' else 14

while True:
  c = sys.stdin.read(1)
  i += 1
  if not c:
    break

  if(len(buf) == n):
    buf.pop()
  buf.insert(0, c)

  if(len(set(buf)) == n):
    print(buf)
    break

print(i)
