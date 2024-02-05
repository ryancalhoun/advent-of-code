#include "sub.h"

Sub::Sub()
  : _position(0)
  , _depth(0)
  , _aim(0)
  , _aiming(false)
{}

void Sub::useAiming()
{
  _aiming = true;
}

void Sub::up(size_t x)
{
  if(_aiming)
    _aim -= x;
  else
    _depth -= x;
}

void Sub::down(size_t x)
{
  if(_aiming)
    _aim += x;
  else
    _depth += x;
}

void Sub::forward(size_t x)
{
  _position += x;
  if(_aiming)
    _depth += _aim * x;
}

size_t Sub::position() const
{
  return _position;
}

size_t Sub::depth() const
{
  return _depth;
}
