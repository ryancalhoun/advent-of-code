#include "wait_for_all.h"

WaitForAll::WaitForAll()
  : _steps(0)
  , _seen(0)
{}

WaitForAll::operator size_t() const
{
  return _steps;
}

WaitForAll::operator bool() const
{
  return _seen != 100;
}

void WaitForAll::operator()(size_t flashes)
{
  ++_steps;
  _seen = flashes;
}
