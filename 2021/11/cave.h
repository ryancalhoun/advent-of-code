#pragma once

#include <iosfwd>
#include <memory>
#include <vector>

class Octopus;

class Cave
{
public:
  static int width;
  static int height;

  size_t step();

  template <typename T>
  size_t evaluate();

protected:
  using OctPtr = std::shared_ptr<Octopus>;

  Cave& operator<<(const OctPtr& o);
  friend std::istream& operator>>(std::istream& is, Cave& c); 
  friend std::ostream& operator<<(std::ostream& os, const Cave& c);

protected:
  std::vector<OctPtr> _octopi;
};

template <typename T>
size_t Cave::evaluate()
{
  T t;
  while(t)
    t(step());

  return t;
}

