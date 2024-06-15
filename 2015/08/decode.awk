#!/usr/bin/awk -f

{
  n = split($0, chars, "")
  e = 0
  for(i = 2; i < n; ++i)
  {
    if(e == 0 && chars[i] == "\\")
    {
      e = 1;
      continue;
    }

    if(e == 1)
    {
      e = 0;
      if(chars[i] == "x")
      {
        printf f(chars[i+1], chars[i+2]);
        i += 2;  
        continue;
      }

    }
    printf chars[i];
  }
  printf "\n"
}

function f(a, b)
{
  return sprintf("%c", byte(a)*16 + byte(b));
}

function byte(c)
{
  if(tolower(c) == "a")
    return 10;
  if(tolower(c) == "b")
    return 11;
  if(tolower(c) == "c")
    return 12;
  if(tolower(c) == "d")
    return 13;
  if(tolower(c) == "e")
    return 14;
  if(tolower(c) == "f")
    return 15;

  return c;
}
