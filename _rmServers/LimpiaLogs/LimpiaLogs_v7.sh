#!/bin/bash

for file in $(find /var/log -type f -size +1G); do
  timestamp=$(date +'%Y%m%d_%H%M')
  compressed_file="/home/rmonla/bkps/bkplogs_$file"_"$timestamp.tar.gz"
  tar czf "$compressed_file" "$file"
  
  # Ejecutar el comando deseado con el archivo comprimido
  echo "El archivo $file supera el límite de 1 GB"
  echo "Se ha creado el archivo comprimido: $compressed_file"
done
