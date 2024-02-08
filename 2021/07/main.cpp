#include "crab.h"
#include "linear_cost.h"
#include "triangular_cost.h"

#include <iostream>
#include <string>
#include <vector>
#include <numeric>

template <typename Cost, typename Crabs>
size_t cost(const Crabs& crabs, int p)
{
  return std::accumulate(crabs.begin(), crabs.end(), size_t(0), Cost(p));
}

int main(int argc, char* const argv[], char* const envp[])
{
  size_t (*cost)(const std::vector<Crab>&, int) = &::cost<LinearCost>;
  while(*envp)
    if(std::string(*envp++) == "PART=2")
      cost = &::cost<TriangularCost>;

  std::string line;
  std::getline(std::cin, line);

  std::vector<Crab> crabs;

  for(size_t begin = 0, end = 0; end != std::string::npos; begin = end + 1)
  {
    end = line.find(',', begin);
    crabs.push_back(std::stoi(line.substr(begin, end-begin)));
  }

  size_t best = ~0;
  for(int p = 0; ; ++p)
  {
    size_t c = cost(crabs, p);

    if(c < best)
      best = c;
    else
      break;
  } 

  std::cout << best << std::endl;
}

