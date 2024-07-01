#include <iostream>
#include <string>

#include "burrow.h"

int main(int argc, char* const argv[], char* const envp[])
{
  Burrow b;
  std::cin >> b;

  std::cout << b.sort() << std::endl;
}
