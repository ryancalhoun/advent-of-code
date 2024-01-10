import unittest
from manhattan import dist, overlap_x

class ManhattanTest(unittest.TestCase):
  def test_dist(self):
    self.assertEqual(dist((0, 0), (0, 1)), 1)
    self.assertEqual(dist((0, 0), (1, 0)), 1)
    self.assertEqual(dist((0, 0), (1, 1)), 2)

  def test_overlap_x(self):
    self.assertEqual(overlap_x((0, 0), 5, 5), None)
    self.assertEqual(overlap_x((0, 0), 5, 4), (-1, 1))
    self.assertEqual(overlap_x((0, 0), 5, 2), (-3, 3))
