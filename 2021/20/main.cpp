#include "enhancement.h"
#include "image.h"
#include <iostream>
#include <string>

int main(int argc, char* const argv[], char* const envp[])
{
  Enhancement e;
  std::cin >> e;

  Image img;
  std::cin >> img;

  size_t n = 2;

  while(*envp)
    if(std::string(*envp++) == "PART=2")
      n = 50;

  for(size_t i = 0; i < n; ++i)
    img = img & e;

  std::cout << img.count_on() << std::endl;
}
