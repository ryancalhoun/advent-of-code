import unittest
from rock import Rock

class TestRock(unittest.TestCase):
  def test_intersect(self):
    r1 = Rock([(0, 0), (0, 1), (0, 2)])
    r2 = Rock([(0, 0), (1, 0), (2, 0)])

    r1.move(1, 1)

#
# ###
#

    r2.move(3, 2)
    self.assertFalse(r1.intersect(r2))

 #
###
 #
    r2.move(0, 2)
    self.assertTrue(r1.intersect(r2))
