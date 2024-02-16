#pragma once

#include <iosfwd>
#include <map>
#include <tuple>

class Rule
{
public:
  char operator[](const std::tuple<char,char>& match) const;

protected:
  friend std::istream& operator>>(std::istream& is, Rule& r);

protected:
  std::map<std::tuple<char,char>,char> _matching;
};

