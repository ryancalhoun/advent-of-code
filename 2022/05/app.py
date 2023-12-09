import sys
import re
import os

stacks = {}

for line in sys.stdin:
  crates = [line[i + 1] for i in range(0, len(line)-1, 4)]

  if len(crates) == 0:
    break

  if crates[0] == '1':
    continue

  for i in range(len(crates)):
    if(len(stacks) < len(crates)):
      stacks[i+1] = []
    if crates[i] != ' ':
      stacks[i+1].insert(0, crates[i])

for line in sys.stdin:
  n, src, dest = [
    int(i) for i in re.search(r'move (\d+) from (\d+) to (\d+)', line).groups()
  ]

  s = stacks[src]
  stacks[dest].extend(s[len(s)-n:len(s)][::-1 if os.environ.get('PART') == '1' else 1])
  stacks[src] = s[0:len(s)-n]

tops = []
for i in range(len(stacks)):
  tops.append(stacks[i+1][-1])

print(''.join(tops))
