#!/bin/bash

# Función para mostrar el uso del script
function usage {
    echo "Uso: $0 -a <archivo a comprimir> -d <carpeta de destino>"
    echo "Opciones:"
    echo "  -a <archivo a comprimir>: especifica el archivo a comprimir"
    echo "  -d <carpeta de destino>: especifica la carpeta de destino"
    echo "  -h: muestra el uso del script"
}

# Verificación de que se proporcionaron los argumentos correctos
while getopts ":a:d:h" opt; do
    case $opt in
        a) archivo="$OPTARG"
            ;;
        d) carpeta_destino="$OPTARG"
            ;;
        h) usage
            exit 0
            ;;
        \?) echo "Opción inválida: -$OPTARG" >&2
            usage
            exit 1
            ;;
        :) echo "Opción -$OPTARG requiere un argumento." >&2
            usage
            exit 1
            ;;
    esac
done

# Verificación de que se proporcionaron los argumentos obligatorios
if [ -z "$archivo" ]; then
    echo "Error: Se debe proporcionar el archivo a comprimir."
    usage
    exit 1
fi

if [ -z "$carpeta_destino" ]; then
    echo "Error: Se debe proporcionar la carpeta de destino."
    usage
    exit 1
fi

# Verificación de que el archivo y la carpeta de destino existen
if [ ! -f "$archivo" ]; then
    echo "Error: El archivo $archivo no existe."
    exit 1
fi

if [ ! -d "$carpeta_destino" ]; then
    echo "Error: La carpeta de destino $carpeta_destino no existe."
    exit 1
fi

# Comprimir el archivo y moverlo a la carpeta de destino
tar -czvf "$carpeta_destino/$(basename "$archivo").tar.gz" "$archivo" && rm "$archivo"
