#pragma once

#include <iosfwd>

class Player
{
public:
  Player();

  int move(int roll);
  int score() const;

protected:
  friend std::istream& operator>>(std::istream& is, Player& p);

protected:
  int _pos;
  int _score;
};
