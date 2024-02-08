#include "descrambler.h"

#include <iostream>
#include <string>
#include <numeric>

int main(int argc, char* const argv[], char* const envp[])
{
  size_t total = 0;

  auto on_digit = +[](int total, int d) { return total + (d == 1 || d == 4 || d == 7 || d == 8); };

  while(*envp)
    if(std::string(*envp++) == "PART=2")
      on_digit = +[](int total, int d) { return total*10 + d; };

  std::string line;
  while(std::getline(std::cin, line))
  {
    Descrambler d(line);
    total += std::accumulate(d.begin(), d.end(), 0, on_digit);
  }

  std::cout << total << std::endl;
}
