#include <stdio.h>
#include <string.h>

int string_scan(const char* s)
{
  int pair = 0;
  int single = 0;

  for(; *s; ++s) {
    char find[3] = {};

    if(!*(s+1))
      break;

    strncpy(find, s, 2);

    if(strstr(s+2, find))
      ++pair;

    if(*s == *(s+2))
      ++single;
  }

  return pair > 0 && single > 0;
}
