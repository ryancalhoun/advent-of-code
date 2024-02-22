#include "probe.h"

Probe::Probe(int dx, int dy)
  : _x(0)
  , _y(0)
  , _dx(dx)
  , _dy(dy)
{}

int Probe::x(int t) const
{
  int x = _x;
  int dx = _dx;
  while(t > 0 && dx > 0)
  {
    x += dx;
    --dx;
    --t;
  }

  return x;
}

int Probe::y(int t) const
{
  int y = _y;
  int dy = _dy;
  while(t > 0)
  {
    y += dy;
    --dy;
    --t;
  }

  return y;
}

int Probe::ymax(int t) const
{
  int max = 0;
  
  int y = _y;
  int dy = _dy;
  while(t > 0)
  {
    y += dy;
    --dy;
    --t;

    if(y > max)
      max = y;

  }

  return max;

}

