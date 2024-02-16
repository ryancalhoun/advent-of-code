#include "polymer.h"
#include "rule.h"

#include <iostream>

int main(int argc, char* const argv[], char* const envp[])
{
  Polymer p;
  std::cin >> p;

  Rule r;
  while(std::cin >> r);

  for(int i = 0; i < 10; ++i)
  {
    p.apply(r);
    p.analyze();

  //  std::cout << p.analyze() << std::endl;
  }
}
