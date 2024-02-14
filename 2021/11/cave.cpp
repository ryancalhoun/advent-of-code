#include "cave.h"
#include "octopus.h"
#include <istream>
#include <ostream>
#include <queue>

int Cave::width = 10;
int Cave::height = 10;

size_t Cave::step()
{
  std::queue<OctPtr> q;

  for(auto o : _octopi)
    q.push(o);

  size_t flashes = 0;
  while(! q.empty())
  {
    OctPtr o = q.front();
    q.pop();

    if(! o->flash())
      continue;

    for(auto n : *o)
      q.push(n);

    ++flashes;
  }

  for(auto o : _octopi)
    o->reset();

  return flashes;
}

Cave& Cave::operator<<(const OctPtr& o)
{
  int x = _octopi.size() % width;
  int y = _octopi.size() / width;

  auto link = [o] (const OctPtr& p)
  {
    o->link(p);
    p->link(o);
  };

  if(x > 0)
  {
    link(_octopi.back());
  }
  if(y > 0)
  {
    link(_octopi[(x) + (y-1)*width]);
    if(x > 0)
      link(_octopi[(x-1) + (y-1)*width]);
    if(x + 1 < width)
      link(_octopi[(x+1) + (y-1)*width]);
  }

  _octopi.push_back(o);

  return *this;
}

std::istream& operator>>(std::istream& is, Cave& c)
{
  char e;
  while(is >> e)
    c << Cave::OctPtr(new Octopus(e - '0'));
  return is;
}

std::ostream& operator<<(std::ostream& os, const Cave& c)
{
  for(auto o : c._octopi)
    os << *o << std::endl;
  return os;
}

