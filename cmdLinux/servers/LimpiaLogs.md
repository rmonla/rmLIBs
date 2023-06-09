#!/bin/bash

# Carpeta de origen
carpeta_origen="/var/log"

# Generar nombre_ori con el nombre de host y la fecha
nombre_host=$(hostname)
fecha=$(date +"%Y%m%d_%H%M%S")
nombre_ori="${nombre_host}_${fecha}"

# Carpeta de destino
carpeta_destino="rmonla@10.0.10.17:/home/rmonla/bkp/${nombre_ori}"

# Verificar si la carpeta de destino existe, si no, crearla
ssh -q rmonla@10.0.10.17 "[ -d \"$carpeta_destino\" ]" || ssh rmonla@10.0.10.17 "mkdir -p \"$carpeta_destino\""

# Copiar archivos de la carpeta de origen a la de destino
echo "Copiando archivos de $carpeta_origen a $carpeta_destino..."
rsync -av --remove-source-files "$carpeta_origen/" "$carpeta_destino"

# Borrar archivos con extensión .gz de la carpeta de origen
echo "Borrando archivos .gz de $carpeta_origen..."
find "$carpeta_origen" -name "*.gz" -delete

# Inicializar o limpiar los archivos messages y syslog
echo "Inicializando o limpiando archivos messages y syslog..."
echo "" > /var/log/messages
echo "" > /var/log/syslog

echo "Proceso finalizado."
