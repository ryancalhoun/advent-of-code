#include <stdio.h>
#include <string.h>

int string_scan(const char* s)
{
  int vowels = 0;
  int dbl = 0;
  for(; *s; ++s) {
    if(strchr("acpx", *s) && *s+1 == *(s+1))
      return -1;

    if(strchr("aeiou", *s))
      ++vowels;
    if(*s == *(s+1))
      ++dbl;
  }

  return vowels >= 3 && dbl >= 1;
}
