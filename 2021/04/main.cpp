#include "bingo.h"
#include "sequence.h"

#include <iostream>
#include <string>
#include <vector>

int main(int argc, char* const argv[], char* const envp[])
{
  bool first = true;
  while(*envp)
    if(std::string(*envp++) == "PART=2")
      first = false;

  std::string line;
  Sequence seq;

  std::getline(std::cin, line);
  seq.parse(line);

  std::vector<Bingo> boards;
  while(std::getline(std::cin, line))
  {
    if(line.empty())
      boards.push_back(Bingo());

    else
      boards.back().parse(line);
  }

  int score = 0;
  for(Sequence::Iterator num = seq.begin(); num != seq.end(); ++num)
  {
    for(std::vector<Bingo>::iterator b = boards.begin(); b != boards.end();)
    {
      if(b->call(*num))
      {
        score = b->score();
        b = boards.erase(b);
      }
      else
        ++b;
    }

    if(first && score > 0)
      break;
  }

  std::cout << score << std::endl;
}

