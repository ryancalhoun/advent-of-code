#include "chunk.h"
#include "autocomplete.h"
#include "syntax_check.h"

#include <iostream>
#include <memory>

int main(int argc, char* const argv[], char* const envp[])
{
  std::unique_ptr<OnError> on_error(new SyntaxCheck);
  while(*envp)
    if(std::string(*envp++) == "PART=2")
      on_error.reset(new Autocomplete);

  Chunk c(*on_error);

  std::string line;
  while(std::getline(std::cin, line))
    c.parse(line);

  std::cout << on_error->score() << std::endl;
}
