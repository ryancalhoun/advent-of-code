import unittest
from pile import Pile

class TestPile(unittest.TestCase):
  def test_add(self):
    pile = Pile((3, 10))
    self.assertEqual(pile.first_pos(), (3, 9))

    self.assertFalse(pile.get(3))

    pile.add((3, 9))
    self.assertEqual(pile.get(3), 9)

    self.assertEqual(pile.first_pos(), (3, 8))
    self.assertEqual(pile.next_pos((3, 8)), [(2, 9), (4, 9)])
    pile.add((2, 9))
    self.assertEqual(pile.get(2), 9)

    self.assertEqual(pile.first_pos(), (3, 8))
    self.assertEqual(pile.next_pos((3, 8)), [(4, 9)])
    pile.add((4, 9))
    self.assertEqual(pile.get(4), 9)

    self.assertEqual(pile.first_pos(), (3, 8))
    self.assertEqual(pile.next_pos((3, 8)), [(3, 8)])

  def test_merge(self):
    pile = Pile((3, 10))
    pile.add((3, 9))
    self.assertEqual(pile.next_pos((3, 8)), [(2, 9), (4, 9)])

    left = Pile((2, 10))
    left.add((2, 9))
    pile.merge(left)

    self.assertEqual(pile.next_pos((3, 8)), [(4, 9)])
      
    right = Pile((4, 10))
    right.add((4, 9))
    pile.merge(right)

    self.assertEqual(pile.next_pos((3, 8)), [(3, 8)])


if __name__ == '__main__':
  unittest.main()
