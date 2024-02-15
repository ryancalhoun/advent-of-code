#include "visitor.h"
#include <cctype>

Visitor::Visitor(int smallCaveRepeat)
  : _smallCaveRepeat(smallCaveRepeat)
{
  add("start");
}

bool Visitor::done() const
{
  return _current == "end";
}

const std::string& Visitor::current() const
{
  return _current;
}

bool Visitor::canVisit(const std::string& cave) const
{
  if(cave == "start")
    return false;

  if(::isupper(cave[0]))
    return true;

  std::map<std::string,int>::const_iterator it = _visited.find(cave);
  if(it == _visited.end())
    return true;

  size_t revisited = 0;
  for(it = _visited.begin(); it != _visited.end(); ++it)
    if(::islower(it->first[0]) && it->second > 1)
      ++revisited;

  return revisited < _smallCaveRepeat;
}

Visitor Visitor::visit(const std::string& cave) const
{
  Visitor v(*this);
  v.add(cave);
  return v;
}

void Visitor::add(const std::string& cave)
{
  ++_visited[_current = cave];
}

