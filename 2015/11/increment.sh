#!/bin/bash

alphabet=({a..z})

function indexof() {
  for i in "${!alphabet[@]}"; do
    if [[ "${alphabet[$i]}" = "$1" ]] || [[ "${alphabet[$i]}" > "$1" ]]; then
      echo $i
      break
    fi
  done
}

read password

for ((i = ${#password}-1; i >= 0; --i)); do
  j=$(indexof ${password:$i:1})
  ((++j))

  if [[ $j -lt ${#alphabet[@]} ]]; then
    break
  fi
done

echo -n ${password:0:$i}
echo -n ${alphabet[$j]}

for ((i += 1; i < ${#password}; ++i)); do
  echo -n a
done
echo
