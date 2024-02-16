#pragma once

#include <deque>
#include <iosfwd>

class Rule;

class Polymer
{
public:
  void apply(const Rule& r);
  size_t analyze() const;

protected:
  friend std::istream& operator>>(std::istream& is, Polymer& p);
  friend std::ostream& operator<<(std::ostream& os, const Polymer& p);

protected:
  std::deque<char> _poly;
};

