#!/bin/bash
# Script para exportar máquinas virtuales de XenServer y enviarlas directamente a un destino remoto
# Ricardo MONLA (https://github.com/rmonla)
# rmServers|rm-xenExportVMs.sh - Versión: 241230-2059

# Configuración inicial
DATE=$(date +%Y_%m_%d-%H_%M_%S)       # Fecha actual
DEST_USER="rmonla"                    # Usuario SSH del destino
DEST_HOST="10.0.10.8"                 # Host SSH del destino
DEST_PORT="7022"                      # Puerto SSH del destino
DEST_DIR="/media/NS8_Disco2/bkps/srv_BKPs" # Directorio remoto donde guardar las exportaciones
CONEXION="${DEST_USER}@${DEST_HOST}"  # Cadena de conexión SSH

# Listar las máquinas virtuales y procesar la salida
sudo xe vm-list is-control-domain=false | grep -E "uuid|name-label" | awk -F ": " '
/uuid/ {uuid=$2} 
/name-label/ {print $2 ":" uuid}
' | while IFS=":" read -r vm_name vm_uuid; do
    # Limpiar espacios y caracteres especiales del nombre de la VM
    vm_name=$(echo "$vm_name" | xargs | sed 's/[^a-zA-Z0-9_-]/_/g')
    vm_uuid=$(echo "$vm_uuid" | xargs)
    
    # Verificar el estado de la VM
    vm_power_state=$(sudo xe vm-param-get uuid="$vm_uuid" param-name=power-state)
    if [ "$vm_power_state" != "halted" ]; then
        echo "La VM '$vm_name' está encendida (estado: $vm_power_state). No se exportará."
        continue
    fi

    # Nombre del archivo remoto
    remote_file="${DEST_DIR}/${vm_name}_${DATE}.xva"
    
    # Informar al usuario sobre la exportación
    echo "Exportando y enviando VM '$vm_name' (UUID: $vm_uuid) al servidor remoto $CONEXION:$remote_file..."
    
    # Exportar y enviar directamente al servidor remoto usando el puerto especificado
    sudo xe vm-export vm="$vm_uuid" filename=| ssh -p "$DEST_PORT" "$CONEXION" "cat > '$remote_file'" && \
    echo "Exportación y transferencia completadas: $remote_file" || \
    echo "Error al exportar y transferir la VM '$vm_name'."
done

