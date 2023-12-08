import sys
import os

scores = {
  'Rock' : 1,
  'Paper': 2,
  'Scissors': 3
}
code = {
  'A': 'Rock',
  'B': 'Paper',
  'C': 'Scissors'
}
beats = {
  'Rock': 'Paper',  
  'Paper': 'Scissors',
  'Scissors': 'Rock'
}

if os.environ.get('PART') == '1':
  code.update({
    'X': 'Rock',
    'Y': 'Paper',
    'Z': 'Scissors'
  })
else:
  code.update({
    'X': (lambda theirs : beats[beats[theirs]]),
    'Y': (lambda theirs : theirs),
    'Z': (lambda theirs : beats[theirs]),
  })

score = 0

for line in sys.stdin:
  theirs, mine = [code[x] for x in line.rstrip().split(' ')]

  if callable(mine):
    mine = mine(theirs)

  score += scores[mine]

  if mine == beats[theirs]:
    score += 6
  elif mine == theirs:
    score += 3

print(score)
