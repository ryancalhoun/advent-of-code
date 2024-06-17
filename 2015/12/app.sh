#!/bin/bash

q='..|select(type|.=="number")'
if [[ $PART = 2 ]]; then
  q='del(..|select((type|.=="object") and (values[]|.=="red")))|'"$q"
fi

jq "$q" | paste -s -d+ - | bc
