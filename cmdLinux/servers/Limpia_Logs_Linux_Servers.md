# Limpia_Logs_Linux_Servers
![Estado: Estable](https://img.shields.io/badge/Estado-Estable-green)
![Versión: 2.2](https://img.shields.io/badge/Versión-Versión%202.2-blue)
[![GitHub](https://img.shields.io/badge/Limpia_Logs_Linux_Servers-black)](https://github.com/rmonla/rmLIBs/blob/3f756a43b60dd80b40274b981fdd3fae4bc8678f/cmdLinux/servers/Limpia_Logs_Linux_Servers.md)
 
----------  
## Autoria
- Lic. Ricardo MONLA - Correo electrónico: rmonla@frlr.utn.edu.ar

--------------  
## Descripción
Este script realiza una serie de tareas relacionadas con la sincronización, respaldo y compresión de archivos de log, junto con limpiar los archivos .log de más de 100MB.

-------------- 
## Script
```bash
clear && \
DIR_ORIGEN="/var/log" && \
read -p -e "\nIngresa el directorio ORIGEN [$DIR_ORIGEN]: " new_input && DIR_ORIGEN=${new_input:-$DIR_ORIGEN} && \
NOM_DIR_BKP="bkplogs_$(hostname)_$(date +"%Y%m%d_%H%M")" && \
DIR_LOCAL="/mnt/$NOM_DIR_BKP" && \
DIR_REMOTO="/home/rmonla/bkp/" && \
DST_USR=$(whoami) && \
DST_IP="10.0.10.17" && \
read -p "Ingresa el USUARIO para conectar en el pc destino[$DST_USR]: " new_input && DST_USR=${new_input:-$DST_USR} && \
read -p -e "\nIngresa la IP destino[$DST_IP]: " new_input && DST_IP=${new_input:-$DST_IP} && \
read -p -e "\nIngresa el directorio DESTINO [$DIR_REMOTO]: " new_input && DIR_REMOTO=${new_input:-$DIR_REMOTO} && \
HOST="$DST_USR@$DST_IP" && \
DIR_REMOTO="$HOST:$DIR_REMOTO" && \
echo -e "\nMontando $DIR_REMOTO..." && \
sudo mkdir -p "$DIR_LOCAL" && sudo sshfs -o allow_other "$DIR_REMOTO" "$DIR_LOCAL" && \
DIR_DESTINO="$DIR_LOCAL/$NOM_DIR_BKP" && \
clear && \
echo -e "\nSincronizando archivos .gz..." && \
sudo rsync -rzPH --no-perms --include='*/' --include='*.gz' --exclude='*' --remove-source-files "$DIR_ORIGEN" "$DIR_DESTINO" && \
echo -e "\nSincronizando archivos .log..." && \
sudo rsync -rzPH --no-perms --include='*/' --include='*.log' --exclude='*' "$DIR_ORIGEN" "$DIR_DESTINO" && \
echo -e "\nLimpiando archivos .log de mas de 100MB..." && \
for flog in $(find "$DIR_ORIGEN" -type f -name "*.log" -size +100M); do sudo echo '' > "$flog"; done && \
echo -e "\nComprimiendo archivos .log de mas de 100MB..." && \
tar cf - "$DIR_DESTINO" | pv | gzip > "$DIR_DESTINO.tar.gz" && rm -r "$DIR_DESTINO" && \
sudo umount "$DIR_LOCAL" && \
echo -e "\nTodas las tareas terminadas."
```

--------------
## Detalle 

| Comando                                                    | Explicación                                                                                     |
|------------------------------------------------------------|------------------------------------------------------------------------------------------------|
| `clear`                                              | Limpia la pantalla de la terminal.                                                             |
| `DIR_ORIGEN="/var/log"`                               | Establece la variable de entorno `DIR_ORIGEN` con la ruta "/var/log" como directorio de origen. |
| `read -p -e "\nIngresa el directorio ORIGEN [$DIR_ORIGEN]: " new_input && DIR_ORIGEN=${new_input:-$DIR_ORIGEN}` | Solicita al usuario que ingrese el directorio de origen, mostrando la ruta predeterminada en la variable `DIR_ORIGEN`. Si no se proporciona ninguna entrada, se utiliza el valor predeterminado. |
| `NOM_DIR_BKP="bkplogs_$(hostname)_$(date +"%Y%m%d_%H%M")"` | Crea un nombre de directorio de respaldo utilizando el nombre del host y la fecha y hora actual. |
| `DIR_LOCAL="/mnt/$NOM_DIR_BKP"`                       | Establece la variable `DIR_LOCAL` con la ruta al directorio local de respaldo.                  |
| `DIR_REMOTO="/home/rmonla/bkp/"`                      | Establece la variable `DIR_REMOTO` con la ruta al directorio remoto de respaldo.                |
| `DST_USR=$(whoami)`                                   | Establece la variable `DST_USR` con el nombre de usuario actual.                                |
| `DST_IP="10.0.10.17"`                                 | Establece la variable `DST_IP` con la dirección IP de destino.                                  |
| `read -p "Ingresa el USUARIO para conectar en el pc destino[$DST_USR]: " new_input && DST_USR=${new_input:-$DST_USR}` | Solicita al usuario que ingrese el nombre de usuario para la conexión al PC de destino, mostrando el valor predeterminado en la variable `DST_USR`. Si no se proporciona ninguna entrada, se utiliza el valor predeterminado. |
| `read -p -e "\nIngresa la IP destino[$DST_IP]: " new_input && DST_IP=${new_input:-$DST_IP}` | Solicita al usuario que ingrese la dirección IP de destino, mostrando el valor predeterminado en la variable `DST_IP`. Si no se proporciona ninguna entrada, se utiliza el valor predeterminado. |
| `read -p -e "\nIngresa el directorio DESTINO [$DIR_REMOTO]: " new_input && DIR_REMOTO=${new_input:-$DIR_REMOTO}` | Solicita al usuario que ingrese el directorio de destino, mostrando la ruta predeterminada en la variable `DIR_REMOTO`. Si no se proporciona ninguna entrada, se utiliza el valor predeterminado. |
| `HOST="$DST_USR@$DST_IP"`                             | Crea la variable `HOST` con el nombre de usuario y la dirección IP para la conexión SSH.        |
| `DIR_REMOTO="$HOST:$DIR_REMOTO"`                       | Actualiza la variable `DIR_REMOTO` para incluir el nombre de usuario y la dirección IP en la ruta del directorio remoto. |
| `echo -e "\nMontando $DIR_REMOTO..."`                  | Imprime un mensaje indicando que se está montando el directorio remoto.                         |
| `sudo mkdir -p "$DIR_LOCAL" && sudo sshfs -o allow_other "$DIR_REMOTO" "$DIR_LOCAL"` | Crea el directorio local de respaldo y monta el directorio remoto en el directorio local utilizando SSHFS. |
| `DIR_DESTINO="$DIR_LOCAL/$NOM_DIR_BKP"`                | Establece la variable `DIR_DESTINO` con la ruta al directorio de destino de respaldo.           |
| `clear`                                              | Limpia la pantalla de la terminal.                                                             |
| `echo -e "\nSincronizando archivos .gz..."`            | Imprime un mensaje indicando que se están sincronizando los archivos .gz.                       |
| `sudo rsync -rzPH --no-perms --include='*/' --include='*.gz' --exclude='*' --remove-source-files "$DIR_ORIGEN" "$DIR_DESTINO"` | Sincroniza los archivos .gz desde el directorio de origen al directorio de destino. |
| `echo -e "\nSincronizando archivos .log..."`           | Imprime un mensaje indicando que se están sincronizando los archivos .log.                      |
| `sudo rsync -rzPH --no-perms --include='*/' --include='*.log' --exclude='*' "$DIR_ORIGEN" "$DIR_DESTINO"` | Sincroniza los archivos .log desde el directorio de origen al directorio de destino. |
| `echo -e "\nLimpiando archivos .log de más de 100MB..."` | Imprime un mensaje indicando que se están limpiando los archivos .log de más de 100MB. |
| `for flog in $(find "$DIR_ORIGEN" -type f -name "*.log" -size +100M); do sudo echo '' > "$flog"; done` | Utiliza un bucle `for` junto con `find` para limpiar el contenido de los archivos .log de más de 100MB. |
| `echo -e "\nComprimiendo archivos .log de más de 100MB..."` | Imprime un mensaje indicando que se están comprimiendo los archivos .log de más de 100MB. |
| `tar cf - "$DIR_DESTINO" | pv | gzip > "$DIR_DESTINO.tar.gz" && rm -r "$DIR_DESTINO"` | Comprime los archivos del directorio de destino en un archivo tar utilizando `tar`, muestra el progreso con `pv`, lo comprime con `gzip` y luego elimina el directorio de destino. |
| `sudo umount "$DIR_LOCAL"`                            | Desmonta el directorio local.                                                                  |
| `echo -e "\nTodas las tareas terminadas."`                   | Imprime un mensaje indicando que todas las tareas han sido completadas.                         |
