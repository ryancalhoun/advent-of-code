#include "cave.h"
#include "risk.h"
#include "basin_size.h"

#include <iostream>
#include <string>

int main(int argc, char* const argv[], char* const envp[])
{
  size_t (Cave::*assess)() const = &Cave::assess<Risk>;
  while(*envp)
    if(std::string(*envp++) == "PART=2")
      assess = &Cave::assess<BasinSize>;

  Cave cave;

  std::string line;
  while(std::getline(std::cin, line))
    cave.scan(line);

  std::cout << (cave.*assess)() << std::endl;
}
