import sys
import os

elves = []
current = None

for line in sys.stdin:
  if line.rstrip() == '':
    current = None
    continue

  if not current:
    current = { 'Calories': [] }
    elves.append(current)

  current['Calories'].append(int(line))

calories = [sum(e['Calories']) for e in elves]
calories.sort(reverse=True)

if os.environ.get('PART') == '1':
  print(calories[0])
else:
  print(sum(calories[0:3]))
