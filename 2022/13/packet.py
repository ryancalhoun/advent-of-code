def build_packet(s):
  v = [[]]
  d = None

  for i in range(len(s)):
    c = s[i]

    if c.isdigit():
      if d is None:
        d = 0
      d *= 10
      d += int(c)

    if c == ',' or c == ']':
      if d is not None:
        v[-1].append(d)
      d = None

    if c == '[':
      v.append([])

    elif c == ']':
      l = v.pop()
      v[-1].append(l)

  return v[0][0]

def compare_packet(p1, p2):
  if type(p1) == int and type(p2) == int:
    return p1 - p2

  if type(p1) == int:
    return compare_packet([p1], p2)

  if type(p2) == int:
    return compare_packet(p1, [p2])

  for i in range(len(p1)):
    if i > len(p2) - 1:
      return 1
    c = compare_packet(p1[i], p2[i])
    if c != 0:
      return c

  if len(p1) < len(p2):
    return -1

  return 0
