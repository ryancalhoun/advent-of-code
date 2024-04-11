#include "die.h"

Die::Die()
  : _val(0)
{}

int Die::roll(int n)
{
  int t = 0;
  while(n-- > 0)
    t += (++_val - 1) % 100 + 1;

  return t;
}

int Die::times() const
{
  return _val;
}

