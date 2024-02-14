#pragma once

#include <vector>
#include <memory>
#include <iosfwd>

class Octopus
{
public:
  Octopus(int e);

  operator int() const;
  bool flash();
  void reset();

  using OctPtr = std::shared_ptr<Octopus>;
  void link(const OctPtr& o);

  std::vector<OctPtr>::const_iterator begin() const;
  std::vector<OctPtr>::const_iterator end() const;

protected:
  friend std::ostream& operator<<(std::ostream& os, const Octopus& o);

protected:
  int _e;
  std::vector<OctPtr> _neighbors;
};
