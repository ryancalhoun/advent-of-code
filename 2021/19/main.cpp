#include "scanner.h"

#include <iostream>
#include <list>
#include <map>

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


int main(int argc, char* const argv[], char* const envp[])
{
  std::list<Scanner> known, unknown;
  std::map<int, std::set<int> > failed;

  while(std::cin)
  {
    unknown.resize(unknown.size() + 1);
    std::cin >> unknown.back();
  }

  known.splice(known.end(), unknown, unknown.begin());
  known.front().fix();

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

  std::set<Beacon> all;
  for(const auto& k : known)
    all.insert(k.begin(), k.end());

  std::cout << all.size() << std::endl;
}
