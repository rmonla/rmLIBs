#!/bin/bash
# Autor: Lic. Ricardo MONLA rmonla@gmail.com
# Uso: ./script.sh -a archivo -d carpeta_destino
#      ./script.sh -h para mostrar la ayuda

# Función de ayuda
mostrar_ayuda() {
  echo "Forma de uso: ./script.sh -a archivo -d carpeta_destino"
  echo "Opciones:"
  echo "  -a  Especifica el archivo a comprimir."
  echo "  -d  Especifica la carpeta de destino para el archivo comprimido."
  echo "  -h  Muestra esta ayuda."
  exit 0
}

# Verificación de argumentos
while getopts "a:d:h" opt; do
  case ${opt} in
    a)
      archivo=$OPTARG
      if [[ ! -f "$archivo" ]]; then
        echo "Error: El archivo $archivo no existe."
        exit 1
      fi
      ;;
    d)
      carpeta_destino=$OPTARG
      if [[ ! -d "$carpeta_destino" ]]; then
        echo "Error: La carpeta destino $carpeta_destino no existe."
        exit 1
      fi
      ;;
    h)
      mostrar_ayuda
      ;;
    \?)
      echo "Error: Opción inválida -$OPTARG" 1>&2
      exit 1
      ;;
    :)
      echo "Error: Opción -$OPTARG requiere un argumento." 1>&2
      exit 1
      ;;
  esac
done

# Verificación de que se especificaron los argumentos requeridos
if [[ -z "$archivo" || -z "$carpeta_destino" ]]; then
  echo "Error: Debe especificar el archivo y la carpeta destino."
  exit 1
fi

# Compresión del archivo a .tar.gz
tar -czvf "$carpeta_destino/$archivo.tar.gz" "$archivo" && rm "$archivo"

echo "El archivo $archivo se comprimió y se guardó en $carpeta_destino."
