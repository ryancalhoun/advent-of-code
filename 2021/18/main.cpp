#include "snailfish.h"
#include "each_pair.h"
#include <string>
#include <vector>
#include <algorithm>
#include <numeric>
#include <iostream>

template <typename T>
int total_magnitude(const T& numbers)
{
  return std::accumulate(numbers.begin(), numbers.end(), Snailfish()).magnitude();
}

template <typename T>
int max_magnitude(const T& numbers)
{
  int max = 0;
  for(const auto& [a,b] : EachPair(numbers.begin(), numbers.end()))
  {
    max = std::max({ (a + b).magnitude(), (b + a).magnitude(), max });
  }
  return max;
}


int main(int argc, char* const argv[], char* const envp[])
{
  std::vector<Snailfish> numbers;
  for(Snailfish sf; std::cin >> sf; numbers.push_back(sf));

  auto mag = &total_magnitude<decltype(numbers)>;
  
  while(*envp)
    if(std::string(*envp++) == "PART=2")
      mag = &max_magnitude<decltype(numbers)>;

  std::cout << (*mag)(numbers) << std::endl;
}
