#!/bin/bash

# Versión: 241211-1207

# Función para mostrar el menú de selección de archivos .xva
function show_menu() {
    echo -e "\n\e[1;34m=== Archivos disponibles para comprimir ===\e[0m"
    select file in *.xva "Salir"; do
        if [[ $REPLY -le $(ls *.xva 2>/dev/null | wc -l) ]] && [[ -f "$file" ]]; then
            echo -e "\n\e[1;32mHas seleccionado: $file\e[0m"
            return
        elif [[ $file == "Salir" ]]; then
            echo "Saliendo del programa."
            exit 0
        else
            echo -e "\n\e[1;31mOpción no válida. Por favor, selecciona un archivo de la lista.\e[0m"
        fi
    done
}

# Función para seleccionar la carpeta de destino
function select_directory() {
    echo -e "\n\e[1;34m=== Selecciona el directorio de destino ===\e[0m"
    select dir in $(find "$PWD" -maxdepth 1 -type d -printf "%f\n") "Crear un nuevo directorio" "Salir"; do
        case "$dir" in
            "Salir")
                echo "Saliendo del programa."
                exit 0
                ;;
            "Crear un nuevo directorio")
                echo -e "\nIngrese el nombre del nuevo directorio:"
                read new_dir
                # Validar nombre del directorio
                if [[ -z "$new_dir" || "$new_dir" =~ [^a-zA-Z0-9._-] ]]; then
                    echo -e "\n\e[1;31mNombre no válido. Solo se permiten letras, números, puntos, guiones y guiones bajos.\e[0m"
                else
                    full_path="$PWD/$new_dir"
                    if [[ -d "$full_path" ]]; then
                        echo -e "\n\e[1;33mEl directorio $new_dir ya existe. Selecciónelo de la lista.\e[0m"
                    else
                        mkdir -p "$full_path"
                        echo -e "\n\e[1;32mEl directorio $new_dir ha sido creado en: $full_path\e[0m"
                        echo "$full_path"
                        return
                    fi
                fi
                ;;
            *)
                # Validar que sea un directorio válido
                if [[ -d "$PWD/$dir" ]]; then
                    echo -e "\n\e[1;32mHas seleccionado el directorio: $dir\e[0m"
                    echo "$PWD/$dir"
                    return
                else
                    echo -e "\n\e[1;31mOpción no válida. Por favor, selecciona un directorio de la lista.\e[0m"
                fi
                ;;
        esac
    done
}


# Función para preguntar si desea borrar el archivo original
function confirm_delete() {
    local input_file=$1
    echo -e "\n\e[1;33m¿Desea eliminar el archivo original $input_file? (s/n):\e[0m"
    read -t 30 response

    if [[ $? -ne 0 ]]; then
        echo -e "\n\e[1;31mNo se recibió respuesta en 30 segundos. El archivo no será eliminado.\e[0m"
        return 1
    fi

    if [[ "$response" =~ ^[sS]$ ]]; then
        echo -e "\e[1;32mEliminando el archivo original $input_file...\e[0m"
        rm -f "$input_file"
        return 0
    else
        echo -e "\e[1;33mEl archivo original $input_file no será eliminado.\e[0m"
        return 1
    fi
}

# Función para comprimir el archivo seleccionado con barra de progreso
function compress_file() {
    local input_file=$1
    local target_dir=$2
    local output_file="$target_dir/${input_file%.xva}.tar.gz"

    # Crear el directorio de destino si no existe
    if [[ ! -d "$target_dir" ]]; then
        echo -e "\n\e[1;33mEl directorio $target_dir no existe. Creándolo...\e[0m"
        mkdir -p "$target_dir"
    fi

    echo -e "\n\e[1;34mComenzando la compresión de $input_file a $output_file...\e[0m"

    # Comprimir con barra de progreso
    tar -czf - "$input_file" | pv -s $(du -sb "$input_file" | awk '{print $1}') > "$output_file"

    if [[ $? -eq 0 ]]; then
        echo -e "\n\e[1;32mCompresión completada: $output_file\e[0m"
        # Confirmar y eliminar el archivo original
        confirm_delete "$input_file"
    else
        echo -e "\n\e[1;31mError durante la compresión. Por favor, verifica los permisos y el espacio disponible.\e[0m"
    fi
}

# Verificar si hay archivos .xva en la carpeta actual
while true; do
    if [[ $(ls *.xva 2>/dev/null | wc -l) -eq 0 ]]; then
        echo -e "\n\e[1;31mNo hay archivos .xva en la carpeta actual. Saliendo.\e[0m"
        exit 0
    fi

    # Mostrar el menú de selección de archivos
    show_menu

    # Seleccionar el directorio de destino
    target_dir=$(select_directory)

    # Comprimir el archivo seleccionado
    compress_file "$file" "$target_dir"

done