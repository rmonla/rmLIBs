#!/bin/bash

# Ruta de los archivos a verificar
files=("kern.log" "messages" "syslog")

# Tamaño límite en bytes (1 GB = 1,073,741,824 bytes)
size_limit=1073741824

# Recorrer los archivos y verificar su tamaño
for file in "${files[@]}"; do
  file_size=$(stat -c "%s" "/var/log/$file")
  if ((file_size > size_limit)); then
    # Crear un archivo comprimido con el nombre único
    timestamp=$(date +'%Y%m%d_%H%M')
    compressed_file="/home/rmonla/bkps/bkplogs_$file"_"$timestamp.tar.gz"
    tar czf "$compressed_file" "/var/log/$file"
    
    # Ejecutar el comando deseado con el archivo comprimido
    echo "El archivo /var/log/$file supera el límite de 1 GB"
    echo "Se ha creado el archivo comprimido: $compressed_file"
  fi
done
