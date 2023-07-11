#!/bin/bash

for file in $(find /var/log -type f -size +500M); do
  timestamp=$(date +'%Y%m%d_%H%M')
  compressed_file="$file"_"$timestamp.tar.gz"
  tar czf "$compressed_file" "$file"
  echo '' > "$file"
  mv "$compressed_file" "/home/rmonla/bkps/$compressed_file"
  echo "Se comprmió y limpió $file ..."
done
