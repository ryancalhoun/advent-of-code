#!/bin/bash

if [[ -z $1 ]]; then
  echo >&2 Use: $0 FILE
  exit
fi

(
  if [[ $PART = 2 ]]; then
    echo inc a
  fi
  cat $1
  echo output ${OUT:-b}
) | ruby -r./computer.rb
