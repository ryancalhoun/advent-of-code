#include "position.h"

Position::Position(size_t risk)
  : _risk(risk)
{}

size_t Position::risk() const
{
  return _risk;
}

void Position::link(Position& p)
{
  _neighbors.push_back(&p);
  p._neighbors.push_back(this);
}

std::list<Position*>::const_iterator Position::begin() const
{
  return _neighbors.begin();
}

std::list<Position*>::const_iterator Position::end() const
{
  return _neighbors.end();
}

