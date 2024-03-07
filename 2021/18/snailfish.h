#pragma once

#include <iosfwd>
#include <list>

class Snailfish
{
public:
  Snailfish();

  Snailfish operator+(const Snailfish& rhs) const;

  int magnitude() const;

protected:
  friend std::istream& operator>>(std::istream& is, Snailfish& sf);
  friend std::ostream& operator<<(std::ostream& os, const Snailfish& sf);

  bool reduce();
  bool explode();
  bool split();

  struct num
  {
    int value;
    int push;
    int pop;
  };

  std::list<num> _number;
};
