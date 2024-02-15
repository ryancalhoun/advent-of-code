#pragma once

#include <map>
#include <vector>
#include <string>
#include <iosfwd>

class CaveSystem
{
public:
  using Links = std::vector<std::string>;
  using Map = std::map<std::string, Links>;

  const Links& operator[](const std::string& cave) const;

protected:
  void link(const std::string& a, const std::string& b);

  friend std::istream& operator>>(std::istream& is, CaveSystem& sys);

protected:
  Map _map;
};
