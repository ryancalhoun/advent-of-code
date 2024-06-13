#!/bin/bash

while read -r line; do
  (cat <<<'
    for($line = 1; <DATA>; ++$line) {
      $f += $_;
      print "$line $f", $/;
    }
    __DATA__'
  sed 's/./\0\n/g' <<< "$line" | sed 's/(/1/;s/)/-1/' | grep 1 ) | perl |
    if [[ $PART = 1 ]]; then
      tail -n1 | awk '{print $2}'
    else
      grep -- - | head -n1 | awk '{print $1}'
    fi
done
