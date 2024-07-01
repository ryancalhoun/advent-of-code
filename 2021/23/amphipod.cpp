#include "amphipod.h"

static size_t type_cost[] = {1, 10, 100, 1000};

Amphipod::Amphipod(char type, size_t pos, size_t depth)
  : _type(type)
  , _pos(pos)
  , _depth(depth)
  , _energy(0)
{}

char Amphipod::type() const
{
  return _type;
}

size_t Amphipod::pos() const
{
  return _pos;
}

size_t Amphipod::depth() const
{
  return _depth;
}

size_t Amphipod::energy() const
{
  return _energy;
}

void Amphipod::move(size_t pos, size_t depth)
{
  size_t dist;
  if(pos > _pos)
    dist = pos - _pos;
  else
    dist = _pos - pos;

  if(depth > _depth)
    dist += depth - _depth;
  else
    dist += _depth - depth;

  _pos = pos;
  _depth = depth;

  _energy += type_cost[_type - 'A'] * dist;
}
