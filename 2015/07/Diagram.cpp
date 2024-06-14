#include "Diagram.h"
#include <istream>

#include <iostream>

void Diagram::reset()
{
  _signals.clear();
}

void Diagram::override(const std::string& name, unsigned value)
{
  _override[name] = value;
}

void Diagram::trace(Tester t)
{
  while(_signals.size() < _diagram.size())
  {
    for(const auto& [k,v] : _diagram)
    {
      std::vector<std::string> e = v;
      for(auto& s : e)
        s.replace(0, std::string::npos, get(s));

      unsigned u;
      if(t(e, u))
        _signals[k] = u;
    }
  }
}

unsigned Diagram::signal(const std::string& out) const
{
  const auto it = _signals.find(out);
  if(it == _signals.end())
    return 0;
  return it->second;
}

void Diagram::add(const std::string& out, const std::string& in)
{
  _diagram[out].push_back(in);
}

std::string Diagram::get(const std::string& name) const
{
  const auto over = _override.find(name);
  if(over != _override.end())
    return std::to_string(over->second);

  const auto it = _signals.find(name);
  if(it != _signals.end())
    return std::to_string(it->second); 

  return name;
}

std::istream& operator>>(std::istream&is, Diagram& d)
{
  for(std::string line; std::getline(is, line);)
  {
    size_t s = line.find(" -> ");
    for(size_t begin = 0, end = 0; end < s; begin = end + 1)
    {
      end = line.find(' ', begin);
      d.add(line.substr(s + 4), line.substr(begin, end-begin));
    }
  }
  return is;
}
