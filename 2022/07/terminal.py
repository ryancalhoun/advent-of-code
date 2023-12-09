def parse_from(f):
  root = {}
  dirs = []

  for line in f:

    w = line.rstrip().split(' ')

    if w[0] == '$':
      if w[1] == 'cd':
        if w[2] == '..':
          dirs.pop()
        elif w[2] == '/':
          dirs = []
        else:
          dirs.append(w[2])
      elif w[1] == 'ls':
        pass

    else:
      current = root
      for d in dirs:
        current = current[d]

      if w[0] == 'dir':
        current[w[1]] = {}
      else:
        current[w[1]] = int(w[0])

  return root
