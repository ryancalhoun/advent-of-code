#!/usr/bin/env python3

from subprocess import Popen, PIPE
import os
import sys

original = 0
encoded = 0

run = os.environ.get("PART") == "1" and "./decode.awk" or "./encode.awk"
with Popen([run], stdin=PIPE, stdout=PIPE, env=dict(os.environ, LANG="c")) as enc:

  for line in sys.stdin:
    original += len(line.strip())
    enc.stdin.write(str.encode(line, 'ascii'))

  enc.stdin.close()

  for line in enc.stdout:
    encoded += len(line.strip())

print(abs(original - encoded))
