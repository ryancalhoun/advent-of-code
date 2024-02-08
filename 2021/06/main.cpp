#include "fish.h"

#include <iostream>
#include <string>

int main(int argc, char* const argv[], char* const envp[])
{
  const size_t lifetime = 8;
  size_t days = 80;

  while(*envp)
    if(std::string(*envp++) == "PART=2")
      days = 256;

  Fish fish(lifetime);

  std::string line;
  std::getline(std::cin, line);
  fish.parse(line);

  for(size_t i = 0; i < days; ++i)
    fish.day();

  std::cout << fish.count() << std::endl;
}

