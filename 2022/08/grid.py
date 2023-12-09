def get_increasing(v, group, inclusive):
  n = 0
  for x in group:
    if inclusive:
      n += 1
    if x >= v:
      break
    if not inclusive:
      n += 1

  return n

def visit(g, inclusive=False):
  for i in range(len(g)):
    for j in range(len(g[i])):
      v = g[i][j]

      left = get_increasing(v, g[i][j-1::-1] if j > 0 else [], inclusive)
      right = get_increasing(v, g[i][j+1:], inclusive)
      top = get_increasing(v, [g[i-y-1][j] for y in range(i)], inclusive)
      bottom = get_increasing(v, [g[y][j] for y in range(i+1, len(g))], inclusive)

      yield (top, i), (bottom, len(g)-1-i), (left, j), (right, len(g[i])-1-j)
