#include "cave.h"
#include "scan.h"

#include <iostream>
#include <string>

int main(int argc, char* const argv[], char* const envp[])
{
  Cave c;
  Scan s;

  while(*envp)
    if(std::string(*envp++) == "PART=2")
      s.repeat(5);

  std::cin >> s;
  for(auto row : s)
    c.add(row.begin(), row.end());
  
  std::cout << c.shortestPath() << std::endl;
}
