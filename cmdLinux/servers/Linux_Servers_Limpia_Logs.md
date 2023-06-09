![Estado: En Desarrollo](https://img.shields.io/badge/Estado-En%20Desarrollo-yellow)
![Versión: 1.2](https://img.shields.io/badge/Versión-Versión%201.2-blue)
[![GitHub](https://img.shields.io/badge/GitHub-KOHA_on_Debian11-black)](https://github.com/rmonla/rmLIBs/blob/af6d12d8d541d8d58578511213d7a03915c42586/cmdLinux/servers/LimpiaLogs.md)
 
- Lic. Ricardo MONLA - Correo electrónico: rmonla@frlr.utn.edu.ar


- Actualizar el sistema operativo.

```bash
clear && \
ORI_DIR="/var/log" && \
DST_NOM="$(hostname)_$(date +"%Y%m%d_%H%M%S")" && \
DST_USR=$(whoami) && \
read -p "Ingresa el USUARIO para conectar en el pc destino[$DST_USR]: " new_input && \
DST_USR=${new_input:-$DST_USR} && \
DST_IP="10.0.10.17" && \
clear && \
read -p "Ingresa la IP destino[$DST_IP]: " new_input && \
DST_IP=${new_input:-$DST_IP} && \
DST_DIR="/home/rmonla/bkp/" && \
clear && \
read -p "Ingresa el DIRECTORIO en el pc destino[$DST_DIR]: " new_input && \
DST_DIR=${new_input:-$DST_DIR} && \
DST_HOST="$DST_USR@$DST_IP" && \
DST_DIR="$DST_DIR$DST_NOM" && \
DESTINO="$DST_USR@$DST_IP:$DST_DIR$DST_NOM" && \
clear && \
echo "Verificando carpeta $ORI_DIR a $DESTINO..." && \
ssh $DST_HOST "mkdir -p \"$DST_DIR\""
rsync -av "$ORI_DIR" "$DST_DIR" && \




 && \

echo "Copiando archivos de $ORI_DIR a $DESTINO..." && \


```


- Archivo rmLimpiaLogs.sh

```bash
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
```
