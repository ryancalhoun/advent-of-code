def reduced(disjoined):
  joined = []
  for d in sorted(disjoined, key=lambda r : r[0]):
    if len(joined) > 0 and d[0] <= joined[-1][1] + 1:
      joined[-1] = (joined[-1][0], max(joined[-1][1], d[1]))
    else:
      joined.append(d)
  return joined
