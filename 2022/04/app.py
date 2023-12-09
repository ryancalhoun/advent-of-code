import sys
import os

def parse_range(r):
  a, b = r.split('-')
  return range(int(a), int(b)+1)

total = 0
for line in sys.stdin:
  a, b = [parse_range(r) for r in line.rstrip().split(',')]
  overlap = range(max(a[0], b[0]), min(a[-1], b[-1]) + 1)

  if os.environ.get('PART') == '1':
    if a == overlap or b == overlap:
      total += 1
  else:
    if len(overlap) > 0:
      total += 1

print(total)
