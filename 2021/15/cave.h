#pragma once
#include "position.h"
#include <list>
#include <iosfwd>

class Position;

class Cave
{
public:
  Cave();

  template <typename T>
  void add(T begin, T end);

  size_t shortestPath() const;

protected:
  void add(size_t risk);
  void add(const Position& p);
  void endRow();

protected:
  std::list<Position> _map;
  decltype(_map)::iterator _up;
  size_t _width;
};

template <typename T>
void Cave::add(T begin, T end)
{
  for(T it = begin; it != end; ++it)
    add(*it);
  endRow();
}

