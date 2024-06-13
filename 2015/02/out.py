#!/usr/bin/env python3

import json
import os
import sys

total = 0
for line in sys.stdin:
  p = json.loads(line)

  if os.environ.get('PART') == '1':
    (a,b,c) = sorted(p['area'])
    total += 3*a + 2*b + 2*c
  else:
    total += min(p['perimeter']) + p['volume']

print(total)
