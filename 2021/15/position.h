#pragma once

#include <list>

class Position
{
public:
  Position(size_t risk);

  size_t risk() const;

  void link(Position& p);
  std::list<Position*>::const_iterator begin() const;
  std::list<Position*>::const_iterator end() const;

protected:
  size_t _risk;
  std::list<Position*> _neighbors;
};
