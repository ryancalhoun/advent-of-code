#include "point.h"
#include "paper.h"
#include "instruction.h"

#include <iostream>
#include <string>

int main(int argc, char* const argv[], char* const envp[])
{
  Paper paper;
  while(! paper.ready() && std::cin >> paper);

  auto procedure = +[](Paper& p)
  {
    Instruction inst;
    std::cin >> inst;
    p.fold(inst);
    std::cout << p.count() << std::endl;
  };

  while(*envp)
    if(std::string(*envp++) == "PART=2")
      procedure = +[](Paper& p)
      {
        for(Instruction inst; std::cin >> inst;)
          p.fold(inst);

        std::cout << p << std::endl; 
      };

  (*procedure)(paper);
}
