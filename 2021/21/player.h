#pragma once

#include <map>
#include <iosfwd>

class RollCount;

class Player
{
public:
  Player();

  int score() const;
  size_t active() const;

  long long move(int target, const RollCount& rollCount);

protected:
  friend std::istream& operator>>(std::istream& is, Player& p);

protected:
  using ScoreCount = std::map<int, long long>;
  using Pos = std::map<int, ScoreCount>;
  Pos _board;
};

