#include "player.h"
#include "roll_count.h"
#include <istream>

Player::Player()
{}

long long Player::move(int target, const RollCount& rollCount)
{
  Pos nextBoard;
  long long wins = 0;

  for(const auto [roll, mul] : rollCount)
  {
    for(const auto& [pos, scoreCount] : _board)
    {
      for(const auto [score, count] : scoreCount)
      {
        int n = ((pos + roll - 1) % 10) + 1;
        int nextScore = score + n;
        int nextCount = count * mul;

        if(nextScore >= target)
          wins += nextCount;
        else
          nextBoard[n][nextScore] += nextCount;
      }
    }
  }

  _board = nextBoard;

  return wins;
}

int Player::score() const
{
  int s = 0;
  for(const auto& [pos, scoreCount] : _board)
    for(const auto [score, count] : scoreCount)
      s += score * count; 

  return s;
}

size_t Player::active() const
{
  return _board.size();
}

std::istream& operator>>(std::istream& is, Player& p)
{
  is.ignore(27, ':');
  int pos;
  is >> pos;

  p._board[pos][0] = 1;

  return is;
}

