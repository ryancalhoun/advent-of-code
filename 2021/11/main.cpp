#include "cave.h"
#include "flash_count.h"
#include "wait_for_all.h"
#include <iostream>
#include <string>

int main(int argc, char* const argv[], char* const envp[])
{
  Cave cave;
  std::cin >> cave;

  auto evaluate = +[](Cave& c) { return c.evaluate<FlashCount>(); };
  while(*envp)
    if(std::string(*envp++) == "PART=2")
      evaluate = +[](Cave& c) { return c.evaluate<WaitForAll>(); };

  std::cout << (*evaluate)(cave) << std::endl;
}
