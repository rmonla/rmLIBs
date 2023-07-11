#!/bin/bash

# Ruta de los archivos a verificar
files=("/var/log/kern.log" "/var/log/messages" "/var/log/syslog")

# Tamaño límite en bytes (1 GB = 1,073,741,824 bytes)
size_limit=1073741824

# Recorrer los archivos y verificar su tamaño
for file in "${files[@]}"; do
  file_size=$(stat -c "%s" "/var/log/$file")
  if ((file_size > size_limit)); then
    # Ejecutar el comando deseado aquí
    echo "El archivo /var/log/$file supera el límite de 1 GB"
    
    # Ejemplo: Comando para truncar el archivo
    echo '' > "/var/log/$file"
    echo "Se ha truncado el archivo"
  fi
done
