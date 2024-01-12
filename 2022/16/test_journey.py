import unittest
from journey import Journey

class TestJourney(unittest.TestCase):
  def test_len(self):
    self.assertEqual(len(Journey()), 0)
    self.assertEqual(len(Journey(['AA', 'BB'])), 2)

  def test_lt(self):
    self.assertFalse(Journey() < None)
    self.assertFalse(Journey(['AA', 'BB'], 5) < Journey())
    self.assertTrue(Journey(['AA', 'BB'], 5) < Journey(['CC', 'DD'], 10))

  def test_add(self):
    self.assertEqual(int(Journey(['AA', 'BB'], 5) + Journey(['CC', 'DD'], 10)), 15)

  def test_contains(self):
    self.assertTrue('AA' in Journey(['AA', 'BB']))
    self.assertFalse('CC' in Journey(['AA', 'BB']))

  def test_iter(self):
    self.assertEqual(list(Journey(['AA', 'BB'], 5)), ['AA', 'BB'])

  def test_and(self):
    self.assertEqual(Journey(['AA', 'BB']) & Journey(['BB', 'CC']), {'BB'})
    self.assertFalse(Journey(['AA', 'BB']) & Journey(['CC', 'DD']))


