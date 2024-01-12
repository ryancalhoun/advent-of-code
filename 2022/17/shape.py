_text_shapes = '''
####

.#.
###
.#.

..#
..#
###

#
#
#
#

##
##
'''

class Shape:
  def __init__(self):
    self.shapes = []
    for line in _text_shapes.splitlines():
      if len(line) == 0:
        self.shapes.append([])
        shape = self.shapes[-1]
        y = 0
        continue
      shape += [(x,y) for x in range(len(line)) if line[x] == '#']
      y += 1

    self.i = 0

  def __iter__(self):
    return self

  def __next__(self):
    i = self.i
    self.i += 1
    return self.shapes[i % len(self.shapes)]

