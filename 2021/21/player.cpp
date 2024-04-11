#include "player.h"
#include <istream>

Player::Player()
  : _pos(0)
  , _score(0)
{}

int Player::move(int roll)
{
  return _score += ((_pos += roll) - 1) % 10 + 1;
}

int Player::score() const
{
  return _score;
}

std::istream& operator>>(std::istream& is, Player& p)
{
  is.ignore(27, ':');
  is >> p._pos;

  return is;
}

