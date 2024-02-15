#include "cave_system.h"

#include <istream>

const CaveSystem::Links& CaveSystem::operator[](const std::string& cave) const
{
  return _map.find(cave)->second;
}

void CaveSystem::link(const std::string& a, const std::string& b)
{
  _map[a].push_back(b);
  _map[b].push_back(a);
}

std::istream& operator>>(std::istream& is, CaveSystem& sys)
{
  std::string from, to;
  std::getline(is, from, '-');
  std::getline(is, to);

  sys.link(from, to);

  return is;
}

