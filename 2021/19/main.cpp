#include "scanner.h"

#include <iostream>
#include <string>
#include <list>
#include <map>
#include <set>

template <typename T, typename F>
bool match(Scanner& s, const T& known, F& failed)
{
  auto& f = failed[s.id()];

  while(s.nextTurn())
  {
    for(const Scanner& k : known)
    {
      if(f.find(k.id()) != f.end())
        continue;

        if(s.alignWith(k))
          return true;
    }
  }

  for(const Scanner& k : known)
    f.insert(k.id());

  return false;
}

template <typename T>
int unique_beacons(const T& scanners)
{
  std::set<Beacon> all;
  for(const auto& s : scanners)
    all.insert(s.begin(), s.end());

  return all.size();
}

template <typename T>
int max_distance(const T& scanners)
{
  int max = 0;

  for(const auto& a : scanners)
  {
    for(const auto& b : scanners)
    {
      int dx = ::abs(a.x() - b.x());
      int dy = ::abs(a.y() - b.y());
      int dz = ::abs(a.z() - b.z());

      max = std::max(max, dx + dy + dz);
    }
  }

  return max;
}

int main(int argc, char* const argv[], char* const envp[])
{
  std::list<Scanner> known, unknown;
  std::map<int, std::set<int> > failed;

  auto count = &unique_beacons<decltype(known)>;
  while(*envp)
    if(std::string(*envp++) == "PART=2")
      count = &max_distance<decltype(known)>;

  while(std::cin)
  {
    unknown.resize(unknown.size() + 1);
    std::cin >> unknown.back();
  }

  known.splice(known.end(), unknown, unknown.begin());

  while(! unknown.empty())
  {
    for(auto it = unknown.begin(); it != unknown.end(); ++it)
    {
      if(::match(*it, known, failed))
      {
        known.splice(known.end(), unknown, it);
        break;
      }
    }
  }

  std::cout << count(known) << std::endl;
}
