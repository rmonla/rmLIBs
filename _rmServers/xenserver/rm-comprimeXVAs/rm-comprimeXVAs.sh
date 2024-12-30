#!/bin/bash
# Script para configurar e implementar Portainer en Docker
# Ricardo MONLA (https://github.com/rmonla)
# rmServers|rm-comprimeXVAs - Versión: 241230-2035

# Modo de operación
silent_mode=false

# Verificar parámetros de línea de comandos
while getopts "s" opt; do
    case $opt in
        s)
            silent_mode=true
            ;;
        *)
            echo "Uso: $0 [-s]"
            exit 1
            ;;
    esac
done

# Mostrar los archivos .xva disponibles
function show_menu() {
    echo -e "\nArchivos disponibles para comprimir:"
    select selected_file in *.xva "Salir"; do
        if [[ $REPLY -le $(ls *.xva 2>/dev/null | wc -l) ]] && [[ -f "$selected_file" ]]; then
            echo -e "\nSeleccionado: $selected_file"
            file="$selected_file"
            break
        elif [[ $selected_file == "Salir" ]]; then
            echo "Saliendo del programa."
            exit 0
        else
            echo -e "\nOpción no válida. Intenta nuevamente."
        fi
    done
}

# Seleccionar el directorio de destino
function select_directory() {
    echo -e "\nSelecciona el directorio de destino:"
    select dir in $(find . -maxdepth 1 -type d -printf "%f\n") "Crear un nuevo directorio" "Salir"; do
        if [[ "$dir" == "Salir" ]]; then
            echo "Saliendo del programa."
            exit 0
        elif [[ "$dir" == "Crear un nuevo directorio" ]]; then
            read -p "\nNombre del nuevo directorio: " new_dir
            if [[ -z "$new_dir" ]]; then
                echo -e "\nEl nombre no puede estar vacío."
            elif [[ -d "./$new_dir" ]]; then
                echo -e "\nEl directorio $new_dir ya existe. Selecciónalo de la lista."
            else
                mkdir -p "./$new_dir"
                target_dir="./$new_dir"
                break
            fi
        elif [[ -d "./$dir" ]]; then
            target_dir="./$dir"
            break
        else
            echo -e "\nOpción no válida. Intenta nuevamente."
        fi
    done
}

# Confirmar eliminación del archivo original
function confirm_delete() {
    local input_file=$1
    if $silent_mode; then
        rm -f "$input_file"
        echo "Archivo eliminado: $input_file"
    else
        read -p "\n¿Eliminar archivo original $input_file? (s/n): " -t 30 response

        if [[ $? -ne 0 ]]; then
            echo -e "\nSin respuesta. El archivo no será eliminado."
            return 1
        fi

        if [[ "$response" =~ ^[sS]$ ]]; then
            rm -f "$input_file"
            echo "Archivo eliminado: $input_file"
        else
            echo "Archivo no eliminado: $input_file"
        fi
    fi
}

# Comprimir el archivo seleccionado
function compress_file() {
    local input_file=$1
    local target_dir=$2
    local output_file="$target_dir/${input_file%.xva}.tar.gz"

    [[ ! -d "$target_dir" ]] && mkdir -p "$target_dir"

    echo -e "\nComprimiendo $input_file a $output_file..."

    tar -czf - "$input_file" | pv -s $(du -sb "$input_file" | awk '{print $1}') > "$output_file"

    if [[ $? -eq 0 ]]; then
        echo -e "\nCompresión completada: $output_file"
        confirm_delete "$input_file"
    else
        echo -e "\nError durante la compresión. Verifica permisos y espacio."
    fi
}

# Operación en modo silencioso
if $silent_mode; then
    echo "Modo silencioso activado."
    for file in *.xva; do
        if [[ -f "$file" ]]; then
            target_dir="."
            compress_file "$file" "$target_dir"
        fi
    done
    exit 0
fi

# Operación en modo asistido
while true; do
    if [[ $(ls *.xva 2>/dev/null | wc -l) -eq 0 ]]; then
        echo -e "\nNo hay archivos .xva disponibles."
        exit 0
    fi

    show_menu
    select_directory
    compress_file "$file" "$target_dir"
done

