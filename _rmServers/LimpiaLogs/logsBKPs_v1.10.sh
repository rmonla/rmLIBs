#!/bin/bash

clear

DIR_DST="/home/rmonla/bkps"
F_LOG="$DIR_DST/bkps.log"

echo 
for F_ORI in $(find /var/log -type f -size +500M); do
  DATA=$(date +'%Y%m%d_%H%M%S')
  F_COMP="$F_ORI"_"$DATA.tar.gz"
  tar czf "$F_COMP" "$F_ORI"
  echo '' > "$F_ORI"
  mv "$F_COMP" "$DIR_DST/"
  echo "$DATA >>>> $F_ORI" >> "$F_LOG"
done

if [ $(wc -l < "$F_LOG") -gt 30 ]; then
  echo "[ ... ]"
  tail -n 30 "$F_LOG"
else
  cat "$F_LOG"
fi

echo 
date
df | grep xvda