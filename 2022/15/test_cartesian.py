import unittest
from cartesian import intersections

class TestCartesian(unittest.TestCase):
  def test_intersections(self):
    segments = [ [(0,0), (5,5)], [(1,3), (3,1)] ]
    self.assertEqual(list(intersections(segments)), [(2,2)])

  def test_outside_segment_end(self):
    segments = [ [(0,0), (5,5)], [(3,1), (4,0)] ]
    self.assertEqual(list(intersections(segments)), [])

  def test_parallel(self):
    segments = [ [(0,0), (5,5)], [(3,1), (4,2)] ]
    self.assertEqual(list(intersections(segments)), [])
