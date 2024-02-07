#include "line.h"
#include "point.h"

#include <iostream>
#include <vector>
#include <map>

int main(int argc, char* const argv[], char* const envp[])
{
  bool includeDiagonal = false;
  while(*envp)
    if(std::string(*envp++) == "PART=2")
      includeDiagonal = true;

  std::vector<Line> lines;

  Line l;
  while(std::cin >> l)
    lines.push_back(l);

  std::map<Point,size_t> points;

  for(std::vector<Line>::const_iterator it = lines.begin(); it != lines.end(); ++it)
  {
    if(! includeDiagonal && ! it->horizontal() && ! it->vertical())
      continue;

    for(Line::Iterator p = it->begin(); p != it->end(); ++p)
      ++points[*p];
  }

  size_t overlapped = 0;
  for(std::map<Point,size_t>::const_iterator it = points.begin(); it != points.end(); ++it)
  {
    if(it->second > 1)
      ++overlapped;
  }

  std::cout << overlapped << std::endl;
}

