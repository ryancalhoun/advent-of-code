#include <iostream>
#include <string>
#include <list>

#include "cube.h"

int main(int argc, char* const argv[], char* const envp[])
{
  size_t (Cube::*vol)() const = &Cube::volume;

  while(*envp)
    if(std::string(*envp++) == "PART=1")
      vol = &Cube::volume<-50, 50>;

  std::list<Cube> cubes;

  Cube cube;
  while(std::cin >> cube)
  {
    for(auto it = cubes.begin(); it != cubes.end(); )
      if(it->slice_with(cube, [&](const Cube& c) { cubes.push_front(c); }))
        cubes.erase(it++);
      else
        ++it;

    if(cube)
      cubes.push_back(cube);
  }

  size_t sum = 0;
  for(const auto& c : cubes)
    sum += (c.*vol)();

  std::cout << sum << std::endl;
}
