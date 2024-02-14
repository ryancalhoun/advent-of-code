#include "octopus.h"
#include <ostream>

Octopus::Octopus(int e)
  : _e(e)
{}

Octopus::operator int() const
{
  return _e;
}

bool Octopus::flash()
{
  return _e++ == 9;
}

void Octopus::reset()
{
  if(_e > 9)
    _e = 0;
}

void Octopus::link(const OctPtr& o)
{
  _neighbors.push_back(o);
}

std::vector<Octopus::OctPtr>::const_iterator Octopus::begin() const
{
  return _neighbors.begin();
}

std::vector<Octopus::OctPtr>::const_iterator Octopus::end() const
{
  return _neighbors.end();
}

std::ostream& operator<<(std::ostream& os, const Octopus& o)
{
  os << o._e << " [";
  for(auto n : o)
    os << " " << (int)*n;
  os << " ]";
  return os;
}

