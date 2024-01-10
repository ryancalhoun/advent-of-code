def midpoint(vals):
  return sorted(vals)[int(len(vals)/2)]

def intersections(edges):
  for i in range(len(edges)):
    p1, q1 = edges[i]

    m1 = int((q1[1] - p1[1]) / (q1[0] - p1[0]))
    b1 = p1[1] - m1 * p1[0]

    for j in range(i+1, len(edges)):
      p2, q2 = edges[j]

      m2 = int((q2[1] - p2[1]) / (q2[0] - p2[0]))
      b2 = p2[1] - m2 * p2[0]

      dm = m1 - m2

      if dm == 0:
        continue

      x = (b2 - b1) / dm
      y = (m1 * b2 - m2 * b1) / dm

      ep = lambda i : [p1[i], p2[i], q1[i], q2[i]]

      if midpoint(ep(0) + [x]) == x and midpoint(ep(1) + [y]) == y:
        yield int(x), int(y)
