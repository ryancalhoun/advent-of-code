#include "sub.h"

#include <iostream>
#include <string>

int main(int argc, char* const argv[], char* const envp[])
{
  Sub sub;

  while(*envp)
  {
    if(std::string(*envp++) == "PART=2")
      sub.useAiming();
  }

  std::string line;
  while(std::getline(std::cin, line))
  {
    if(line.compare(0, 7, "forward") == 0)
      sub.forward(std::stoi(line.substr(8)));
    else if(line.compare(0, 4, "down") == 0)
      sub.down(std::stoi(line.substr(5)));
    else if(line.compare(0, 2, "up") == 0)
      sub.up(std::stoi(line.substr(3)));
  }

  std::cout << sub.position() * sub.depth() << std::endl;
}

