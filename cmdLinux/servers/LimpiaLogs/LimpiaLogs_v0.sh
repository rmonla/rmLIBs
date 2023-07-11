#!/bin/bash

# Limpiar la pantalla del terminal
clear

# Directorio ORIGEN
DIR_ORIGEN="/var/log"
read -p $'\nIngresa el directorio ORIGEN ['$DIR_ORIGEN']: ' new_input
DIR_ORIGEN=${new_input:-$DIR_ORIGEN}

# Nombre del directorio de respaldo y ruta del directorio local
NOM_DIR_BKP="bkplogs_$(hostname)_$(date +"%Y%m%d_%H%M")"
DIR_LOCAL="/mnt/$NOM_DIR_BKP"

# Usuario de destino
DST_USR=$(whoami)
read -p "Ingresa el USUARIO para conectar en el PC destino [$DST_USR]: " new_input
DST_USR=${new_input:-$DST_USR}

# Dirección IP de destino
DST_IP="10.0.10.17"
read -p $'\nIngresa la IP de destino ['$DST_IP']: ' new_input
DST_IP=${new_input:-$DST_IP}

# Ruta del directorio remoto
DIR_REMOTO="/home/rmonla/bkp/"
read -p $'\nIngresa la ruta del directorio DESTINO ['$DIR_REMOTO']: ' new_input
DIR_REMOTO=${new_input:-$DIR_REMOTO}

# Host de destino y ruta del directorio remoto
HOST="$DST_USR@$DST_IP"
DIR_REMOTO="$HOST:$DIR_REMOTO"

# Montar el directorio remoto
echo -e $'\nMontando $DIR_REMOTO...'
sudo mkdir -p "$DIR_LOCAL"
sudo sshfs -o allow_other "$DIR_REMOTO" "$DIR_LOCAL"

# Establecer la ruta del directorio de destino
DIR_DESTINO="$DIR_LOCAL/$NOM_DIR_BKP"

# Sincronizar archivos -log y .gz desde ORIGEN a DESTINO
echo -e $'\nSincronizando archivos .log y .gz...'
sudo rsync -avz --include='*.log' --include='*.gz' --exclude='*' "$DIR_ORIGEN/" "$DIR_DESTINO"

# Liberar espacio eliminado los archivos .gz
echo -e $'\Eliminando archivos .gz...'
find "$DIR_ORIGEN" -type f -name "*.gz" -exec sudo rm {} \;

# Limpiar archivos .log mayores a 100MB
echo -e $'\nLimpiando archivos .log de más de 100MB...'
find "$DIR_ORIGEN" -type f -name "*.log" -size +100M -exec sudo echo '' > {} \;

# Comprimir directorio DESTINO
echo -e $'\nComprimiendo directorio DESTINO...'
tar cf - "$DIR_DESTINO" | pv | gzip > "$DIR_DESTINO.tar.gz"
rm -r "$DIR_DESTINO"

# Desmontar el directorio local
sudo umount "$DIR_LOCAL"

# Imprimir mensaje de finalización
echo -e $'\nTodas las tareas han finalizado.'
