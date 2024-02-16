#pragma once

#include <map>
#include <tuple>
#include <iosfwd>

class Rule;

class Polymer
{
public:
  Polymer();

  void apply(const Rule& r);
  size_t analyze() const;

  void add(const std::tuple<char,char>& pair);

protected:
  std::map<std::tuple<char,char>, size_t> _pairs;
  char _first;
};

std::istream& operator>>(std::istream& is, Polymer& p);
