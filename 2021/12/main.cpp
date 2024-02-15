#include "cave_system.h"
#include "visitor.h"
#include <iostream>
#include <string>

size_t paths(const CaveSystem& sys, const Visitor& visitor)
{
  if(visitor.done())
    return 1;

  size_t count = 0;
  for(auto link : sys[visitor.current()])
    if(visitor.canVisit(link))
      count += paths(sys, visitor.visit(link));

  return count;
}

int main(int argc, char* const argv[], char* const envp[])
{
  int repeat = 0;
  while(*envp)
    if(std::string(*envp++) == "PART=2")
      repeat = 1;

  CaveSystem sys;
  while(std::cin >> sys);

  std::cout << paths(sys, repeat) << std::endl;
}
