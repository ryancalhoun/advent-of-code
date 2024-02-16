#include "rule.h"

#include <istream>

char Rule::operator[](const std::tuple<char,char>& match) const
{
  return _matching.find(match)->second;
}

std::istream& operator>>(std::istream& is, Rule& r)
{
  std::tuple<char,char> m;

  is >> std::get<0>(m) >> std::get<1>(m);
  is.ignore(2, '>');

  is >> r._matching[m];  

  return is;
}
