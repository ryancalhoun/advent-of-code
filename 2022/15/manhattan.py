def dist(a, b):
  return abs(b[0] - a[0]) + abs(b[1] - a[1])

def overlap_x(a, d, y):
  dy = abs(a[1] - y)
  dx = d - dy
  if dx > 0:
    return (a[0] - dx, a[0] + dx)

