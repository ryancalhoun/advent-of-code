
def directory_sizes(d):
  size = 0
  sizes = []
  for name,val in d.items():
    if type(val) == dict:
      sizes.extend(directory_sizes(val))
    else:
      size += val
  size += sum([s for s in sizes if type(s) == int])

  return [size, sizes]
