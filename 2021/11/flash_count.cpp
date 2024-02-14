#include "flash_count.h"

FlashCount::FlashCount()
  : _total(0)
  , _steps(0)
{}

FlashCount::operator size_t() const
{
  return _total;
}

FlashCount::operator bool() const
{
  return _steps < 100;
}

void FlashCount::operator()(size_t flashes)
{
  ++_steps;
  _total += flashes;
}
