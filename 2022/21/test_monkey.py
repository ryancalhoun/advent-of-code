import unittest
from monkey import Tree

class TestTree(unittest.TestCase):
  def test_add(self):
    tree = Tree()
    tree.parse('a : b + c')
    tree.parse('b : 3')
    tree.parse('c : 5')

    self.assertEqual(tree['a'].evaluate(), 8)

  def test_sub(self):
    tree = Tree()
    tree.parse('a : b - c')
    tree.parse('b : 3')
    tree.parse('c : 5')

    self.assertEqual(tree['a'].evaluate(), -2)

  def test_mul(self):
    tree = Tree()
    tree.parse('a : b * c')
    tree.parse('b : 3')
    tree.parse('c : 5')

    self.assertEqual(tree['a'].evaluate(), 15)

  def test_div(self):
    tree = Tree()
    tree.parse('a : b / c')
    tree.parse('b : 8')
    tree.parse('c : 4')

    self.assertEqual(tree['a'].evaluate(), 2)
