#include "window.h"

#include <iostream>
#include <string>
#include <algorithm>

int main(int argc, char* const argv[], char* const envp[])
{
  size_t window_size = 1;
  while(*envp) {
    if(std::string(*envp++) == "PART=2")
      window_size = 3;
  }

  Window w(window_size);
  Window v(window_size);

  std::string line;

  int increases = 0;

  while(std::getline(std::cin, line))
  {
    int n = std::stoi(line);
    v.add(n);

    if(v > w)
      ++increases;

    w.add(n);
  }

  std::cout << increases << std::endl;

  return 0;
}
