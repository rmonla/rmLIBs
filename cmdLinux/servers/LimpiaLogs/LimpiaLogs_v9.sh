#!/bin/bash

# watch -n 300  

DIR_DST="/home/rmonla/bkps"
F_LOG="$DIR_DST/bkps.log"

for F_ORI in $(find /var/log -type f -size +500M); do
  DATA=$(date +'%Y%m%d_%H%M%S')
  F_COMP="$F_ORI"_"$DATA.tar.gz"
  tar czf "$F_COMP" "$F_ORI"
  echo '' > "$F_ORI"
  mv "$F_COMP" "$DIR_DST/"
  echo "$DATA >>>> $F_ORI" >> "$F_LOG"
done

cat "$F_LOG"
echo 
date
df | grep xvda
