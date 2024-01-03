import sys
import os
import functools
from packet import build_packet, compare_packet

def read_packet_pair(f):
  i = 0
  while True:
    i += 1
    p1 = f.readline().rstrip()
    p2 = f.readline().rstrip()

    yield i, build_packet(p1), build_packet(p2)

    if not f.readline():
      break


if os.environ.get('PART') == '1':
  total = 0
  for i, p1, p2 in read_packet_pair(sys.stdin):
    if compare_packet(p1, p2) < 0:
      total += i

  print(total)  

else:
  packets = [[[2]], [[6]]]

  for i, p1, p2 in read_packet_pair(sys.stdin):
    packets += [p1, p2]

  packets.sort(key=functools.cmp_to_key(compare_packet)) 

  i = packets.index([[2]])
  j = packets.index([[6]])

  print((i+1) * (j+1))
