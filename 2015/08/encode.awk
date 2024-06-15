#!/usr/bin/awk -f

{
  printf "\"";

  n = split($0, chars, "")
  for(i = 1; i <= n; ++i)
  {
    if(chars[i] == "\"" || chars[i] == "\\")
      printf "\\";

    printf chars[i];
  }

  printf "\"\n";
}
