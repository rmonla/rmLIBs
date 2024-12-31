#!/bin/bash
# Ricardo MONLA (https://github.com/rmonla)
# rmServers|rm-bkpVmsProxmox.sh - Versión: 241230-2117

mostrar_ayuda() {
    echo "Uso: $0 <conexión> [-h] [-v]"
    echo "  <conexión>    Dirección de conexión (obligatorio)"
    echo "  -h            Muestra esta ayuda y sale"
    echo "  -v            Habilita la depuración"
    exit 0
}

# Validar que se proporcionó al menos un argumento
if [ $# -lt 1 ]; then
    echo "Error: Se requiere un argumento para la conexión."
    mostrar_ayuda
fi

# Leer el primer argumento como conexión
cnxSRV="$1"
shift # Desplazar los argumentos para procesar los opcionales (-h, -v)

# Leer parámetros opcionales
while getopts ":hv" opt; do
    case $opt in
        v) set -x ;;  # Habilitar depuración
        h) mostrar_ayuda ;;
        *) mostrar_ayuda ;;
    esac
done

# Validar que pv está instalado
command -v pv > /dev/null || {
    echo "Error: 'pv' no está instalado. Instálalo para continuar." >&2
    exit 1
}

# Obtener el directorio del script
dirHOME=$(dirname "$(realpath "$0")")

# Definir directorios relativos al directorio del script
dirSYNC="$dirHOME/_sync_data"  # Carpeta temporal para sincronización
dirPROC="$dirHOME/"  # Carpeta donde se procesarán los archivos
mkdir -p "$dirSYNC" "$dirPROC"

# Sincronizar VMs
clear && echo "Iniciando sincronización..."
rsync -avh --progress -e ssh "$cnxSRV:/var/lib/vz/dump/" "$dirSYNC/" || {
    echo "Error: Falló la sincronización desde $cnxSRV:/var/lib/vz/dump/ a $dirSYNC" >&2
    exit 1
}

# Procesar archivos
for log_file in "$dirSYNC"/*.log; do
    nomINI=$(basename "$log_file" .log)

    # Validar que el archivo log tiene contenido
    if [ -z "$nomINI" ]; then
        echo "Advertencia: No se pudo obtener un nombre base válido para $log_file. Saltando..."
        continue
    fi

    # Buscar archivo .notes correspondiente usando un patrón
    archNOTE=$(find "$dirSYNC" -type f -name "${nomINI}*.notes" -print -quit)
    if [ -z "$archNOTE" ]; then
        echo "Advertencia: Archivo .notes no encontrado para $nomINI. Saltando..."
        continue
    fi

    # Obtener nombre de la VM desde el archivo .notes
    vmNOM=$(cat "$archNOTE" | tr -d '[:space:]')  # Eliminar espacios y saltos de línea
    if [ -z "$vmNOM" ]; then
        echo "Advertencia: El archivo .notes para $nomINI está vacío. Saltando..."
        continue
    fi

    # Reemplazar "vzdump-qemu" en el nombre del archivo comprimido
    nomFINAL=$(echo "$nomINI" | sed "s/vzdump-qemu/$vmNOM/")
    if [ -z "$nomFINAL" ]; then
        echo "Error: No se pudo reemplazar 'vzdump-qemu' en $nomINI. Saltando..."
        continue
    fi

    # Crear directorio con el nombre de la VM
    vmDIR="$dirPROC/$vmNOM/${nomFINAL}"
    mkdir -p "$vmDIR" || { echo "Error creando $vmDIR" >&2; exit 1; }

    # Copiar archivos relacionados a la carpeta de la VM
    mv "$dirSYNC/${nomINI}"* "$vmDIR" || { echo "Error copiando archivos para $vmDIR"; exit 1; }

    # Comprimir directorio
    echo "Comprimiendo $vmDIR ..."
    tar -cf - -C "$(dirname "$vmDIR")" "$(basename "$vmDIR")" | \
    pv -s $(du -sb "$vmDIR" | awk '{print $1}') | gzip > "$dirPROC/$vmNOM/${nomFINAL}.tar.gz" || {
        echo "Error: Falló la compresión de $vmDIR." >&2
        exit 1
    }

    # Eliminar directorio temporal
    rm -rf "$vmDIR" || { echo "Error eliminando $vmDIR. Revisa permisos." >&2; exit 1; }
done

echo "Procesamiento completado. Archivos comprimidos en $dirPROC."
