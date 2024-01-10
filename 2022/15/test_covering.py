import unittest
from covering import reduced

class TestCovering(unittest.TestCase):
  def test_not_reduced(self):
    disjoined = [ (0, 2), (4, 5) ]
    self.assertEqual(reduced(disjoined), disjoined)

  def test_reduced_adjacent(self):
    disjoined = [ (0, 2), (3, 5) ]
    self.assertEqual(reduced(disjoined), [(0, 5)])

  def test_reduced_overlapped(self):
    disjoined = [ (0, 2), (1, 5) ]
    self.assertEqual(reduced(disjoined), [(0, 5)])
