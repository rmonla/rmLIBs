#!/bin/bash
# Autor: Lic. Ricardo MONLA rmonla@gmail.com
# Descripción: Este script comprime un archivo y lo mueve a una carpeta de destino
# Uso: rmComprimirYMover.sh -a archivo -d carpeta_destino
#       -a: archivo a comprimir
#       -d: carpeta de destino
#       -h: muestra el uso del script

if [ "$#" -ne 4 ]; then
  echo "Error: Se deben proporcionar los argumentos -a y -d."
  echo "Uso: rmComprimirYMover.sh -a archivo -d carpeta_destino"
  exit 1
fi

while getopts "a:d:h" opt; do
  case $opt in
    a) archivo="$OPTARG" ;;
    d) destino="$OPTARG" ;;
    h) echo "Uso: rmComprimirYMover.sh -a archivo -d carpeta_destino"
       echo "       -a: archivo a comprimir"
       echo "       -d: carpeta de destino"
       echo "       -h: muestra el uso del script"
       exit ;;
    *) echo "Error: Argumento inválido."
       exit 1 ;;
  esac
done

if [ ! -f "$archivo" ]; then
  echo "Error: El archivo $archivo no existe."
  exit 1
fi

if [ ! -d "$destino" ]; then
  echo "Error: La carpeta de destino $destino no existe."
  exit 1
fi

tar -czvf "$destino/${archivo%%.*}.tar.gz" "$archivo" && rm "$archivo"
