#include "player.h"
#include "die.h"
#include "quantum_die.h"
#include <iostream>
#include <algorithm>

long long losing_score(Player p[])
{
  Die d;

  int i = 0;

  while(p[i++%2].move(1000, d.roll(3)) == 0);

  return d.times() * p[i%2].score();
}

long long quantum_score(Player p[])
{
  QuantumDie d;

  long long u1(0), u2(0);
  long long m1(1), m2(1);

  for(;;)
  {
    long long w1 = p[0].move(21, d);
    long long w2 = p[1].move(21, d);

    u1 += w1 * m1;

    m1 *= d.count();
    m1 -= w2;

    m2 *= d.count();
    m2 -= w1;

    u2 += w2 * m2;

    if(p[0].active() == 0 && p[1].active() == 0)
      break;
  }

  return std::max(u1, u2);
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
