#include "probe.h"
#include "target_area.h"
#include <iostream>

int main(int argc, char* const argv[], char* const envp[])
{
  TargetArea area;
  std::cin >> area;

  int ymax = 0;  
  int count = 0;

  for(int dx = 0; dx <= area.xmax(); ++dx)
  {
    for(int dy = area.ymin(); dy < 100; ++dy)
    {
      Probe p(dx, dy);
      bool in = false;
      for(int t = 0; t < 200; ++t)
      {
        if(area.in(p.x(t), p.y(t)))
        {
          in = true;
          int ym = p.ymax(t);
          if(ym > ymax)
            ymax = ym;
        }
      }
      if(in)
        ++count;
    }
  }

  std::cout << ymax << std::endl;
  std::cout << count << std::endl;
}
