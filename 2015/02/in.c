#include <stdio.h>

int main(int argc, const char* argv[])
{
  int w, h, l;
  while(scanf("%dx%dx%d\n", &w, &h, &l) != -1)
  {
    printf("{\"perimeter\":[%d,%d,%d]", 2*(w+l), 2*(w+h), 2*(h+l));
    printf(",\"area\":[%d,%d,%d]", w*l, w*h, h*l);
    printf(",\"volume\":%d}\n", w*h*l);
  }

  return 0;
}
