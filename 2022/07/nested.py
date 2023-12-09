def all_values(values):
  for v in values:
    if type(v) == list:
      yield from all_values(v)
    else:
      yield v
