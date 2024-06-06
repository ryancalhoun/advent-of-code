#!/bin/bash

file=full.txt
part=1

while getopts "sp:" opt; do
  case "$opt" in
    s)
      echo SAMPLE
    ;;
    p)
      echo PART $OPTARG
    ;;
  esac
done
