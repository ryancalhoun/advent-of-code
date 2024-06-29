class Cube:

  def __init__(self, board):

    d1, d2 = sorted(board.size())
    s1 = d1 // 3
    s2 = d2 // 4

    if s1 == s2:
      self.scale = s1
      self.shape = board.shape(s1)

    print(Cube.WAYS[self.shape])

  WAYS = {
    ((False, False, True, False),
     (True,  True,  True, False),
     (False, False, True, True)) : '1',

    ((False, True,  True),
     (False, True,  False),
     (True,  True,  False),
     (True,  False, False)) : '2',
  }

