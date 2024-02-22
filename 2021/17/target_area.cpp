#include "target_area.h"
#include <istream>
#include <string>

TargetArea::TargetArea()
  : _xmin(0)
  , _xmax(0)
  , _ymin(0)
  , _ymax(0)
{}

bool TargetArea::in(int x, int y) const
{
  return x >= _xmin && x <= _xmax && y >= _ymin && y <= _ymax;
}

int TargetArea::xmax() const
{
  return _xmax;
}

int TargetArea::ymin() const
{
  return _ymin;
}

std::istream& operator>>(std::istream& is, TargetArea& area)
{
  std::string s;
  std::getline(is, s, '=');
  is >> area._xmin;
  is.ignore(2);
  is >> area._xmax;

  std::getline(is, s, '=');
  is >> area._ymin;
  is.ignore(2);
  is >> area._ymax;

  return is;
}
