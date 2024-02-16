#include "polymer.h"
#include "rule.h"

#include <istream>
#include <ostream>
#include <string>
#include <map>
#include <algorithm>

void Polymer::apply(const Rule& r)
{
  std::deque<char> result { _poly.front() };
  _poly.pop_front();

  while(! _poly.empty())
  {
    std::tuple<char,char> pair = { result.back(), _poly.front() };

    result.push_back(r[pair]);
    result.push_back(_poly.front());

    _poly.pop_front();
  }

  _poly.assign(result.begin(), result.end());
}

#include <iostream>
size_t Polymer::analyze() const
{
  std::map<char,size_t> quant;

  for(char c : _poly)
    ++quant[c];

  std::deque<size_t> freq;
  std::transform(quant.begin(), quant.end(), std::back_inserter(freq), [](auto p) { return p.second; });

  std::sort(freq.begin(), freq.end());

  std::cout << freq.back() << " " << freq.front() << std::endl;

  return freq.back() - freq.front();
}

std::istream& operator>>(std::istream& is, Polymer& p)
{
  std::string start;
  is >> start;

  for(char c : start)
    p._poly.push_back(c);

  return is;
}

std::ostream& operator<<(std::ostream& os, const Polymer& p)
{
  for(char c : p._poly)
    os << c;
  return os;
}
