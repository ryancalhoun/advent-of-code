#include "polymer.h"
#include "rule.h"

#include <istream>
#include <string>
#include <algorithm>
#include <deque>

Polymer::Polymer()
  : _first(0)
{}

void Polymer::apply(const Rule& r)
{
  decltype(_pairs) result;
  for(auto p : _pairs)
  {
    char c = r[p.first];
    result[decltype(_pairs)::key_type(std::get<0>(p.first), c)] += p.second;
    result[decltype(_pairs)::key_type(c, std::get<1>(p.first))] += p.second;
  }

  _pairs = result;
}

size_t Polymer::analyze() const
{
  std::map<char,size_t> quant { { _first, 1 } };

  for(auto p : _pairs)
    quant[std::get<1>(p.first)] += p.second;

  std::deque<size_t> freq;
  std::transform(quant.begin(), quant.end(), std::back_inserter(freq), [](auto p) { return p.second; });

  std::sort(freq.begin(), freq.end());

  return freq.back() - freq.front();
}

void Polymer::add(const std::tuple<char,char>& pair)
{
  if(! _first)
    _first = std::get<0>(pair);
  ++_pairs[pair];
}

std::istream& operator>>(std::istream& is, Polymer& p)
{
  std::string start;
  is >> start;

  std::deque<char> pair;
  for(char c : start)
  {
    pair.push_back(c);
    if(pair.size() == 2)
    {
      p.add(std::tuple<char,char>(pair.front(), pair.back()));
      pair.pop_front();
    }
  }

  return is;
}

