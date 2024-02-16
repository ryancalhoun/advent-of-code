#include "polymer.h"
#include "rule.h"

#include <iostream>

int main(int argc, char* const argv[], char* const envp[])
{
  int steps = 10;
  while(*envp)
    if(std::string(*envp++) == "PART=2")
      steps = 40;

  Polymer p;
  std::cin >> p;

  Rule r;
  while(std::cin >> r);

  for(int i = 0; i < steps; ++i)
    p.apply(r);

  std::cout << p.analyze() << std::endl;
}
