#include "player.h"
#include "die.h"
#include "quantum_die.h"
#include <iostream>

long long losing_score(Player p[])
{
  Die d;

  int i = 0;
  while(p[i++%2].move(d.roll(3)) < 1000);

  return d.times() * p[i%2].score();
}

long long quantum_score(Player p[])
{
  QuantumDie d;

  for(const auto& [score, count] : d)
  {
  } 

  return 0;
}

int main(int argc, char* const argv[], char* const envp[])
{
  Player p[2];

  std::cin >> p[0];
  std::cin >> p[1];

  auto game = &::losing_score;
  while(*envp)
    if(std::string(*envp++) == "PART=2")
      game = &::quantum_score;

  std::cout << (*game)(p) << std::endl;
}
