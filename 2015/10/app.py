#!/usr/bin/env python3

import os
import sys

r, w = os.pipe2(os.O_CLOEXEC)

def create_proc(p_in):

  out, p_out = os.pipe2(os.O_CLOEXEC)

  pid = os.fork()
  if pid > 0:
    os.close(p_in)
    os.close(p_out)
    return out
  else:
    os.dup2(p_in, 0)
    os.dup2(p_out, 1)
    os.execlp('node', 'node', 'seesay.js')

for i in range(int(os.environ.get('N'))):
  r = create_proc(r)

for line in sys.stdin:
  os.write(w, str.encode(line))
os.close(w)

count = 0
while (b := os.read(r, 1024)):
  count += len(b)

print(count-1)

