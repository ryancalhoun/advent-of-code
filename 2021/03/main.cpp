#include "diagnostic.h"

#include <iostream>
#include <string>

int main(int argc, char* const argv[], char* const envp[])
{
  unsigned (Diagnostic::*rating)() const = &Diagnostic::powerConsumption;
  while(*envp)
    if(std::string(*envp++) == "PART=2")
      rating = &Diagnostic::lifeSupport;

  Diagnostic d;

  std::string line;
  while(std::getline(std::cin, line))
    d.add(line);

  std::cout << (d.*rating)() << std::endl;

  return 0;
}

