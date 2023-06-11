# Limpia_Logs_Linux_Servers
![Estado: Estable](https://img.shields.io/badge/Estado-Estable-green)
![Versión: 2.3](https://img.shields.io/badge/Versión-Versión%202.3-blue)
[![GitHub](https://img.shields.io/badge/Limpia_Logs_Linux_Servers-black)](https://github.com/rmonla/rmLIBs/blob/3f756a43b60dd80b40274b981fdd3fae4bc8678f/cmdLinux/servers/Limpia_Logs_Linux_Servers.md)
- Lic. Ricardo MONLA - rmonla@frlr.utn.edu.ar
--------------  
## Descripción
Este script realiza una serie de tareas relacionadas con la sincronización, respaldo y compresión de archivos de log, junto con limpiar los archivos .log de más de 100MB.
 
## Script
```bash
clear && \
DIR_ORIGEN="/var/log" && read -p -e "\nIngresa el directorio ORIGEN [$DIR_ORIGEN]: " new_input && DIR_ORIGEN=${new_input:-$DIR_ORIGEN} && \
NOM_DIR_BKP="bkplogs_$(hostname)_$(date +"%Y%m%d_%H%M")" && DIR_LOCAL="/mnt/$NOM_DIR_BKP" && \
DST_USR=$(whoami) && read -p "Ingresa el USUARIO para conectar en el pc destino[$DST_USR]: " new_input && DST_USR=${new_input:-$DST_USR} && \
DST_IP="10.0.10.17" && read -p -e "\nIngresa la IP destino[$DST_IP]: " new_input && DST_IP=${new_input:-$DST_IP} && \
DIR_REMOTO="/home/rmonla/bkp/" && read -p -e "\nIngresa el directorio DESTINO [$DIR_REMOTO]: " new_input && DIR_REMOTO=${new_input:-$DIR_REMOTO} && \
HOST="$DST_USR@$DST_IP" && DIR_REMOTO="$HOST:$DIR_REMOTO" && \
echo -e "\nMontando $DIR_REMOTO..." && sudo mkdir -p "$DIR_LOCAL" && sudo sshfs -o allow_other "$DIR_REMOTO" "$DIR_LOCAL" && \
DIR_DESTINO="$DIR_LOCAL/$NOM_DIR_BKP" && \
echo -e "\nSincronizando archivos .gz..." && sudo rsync -rzPH --no-perms --include='*/' --include='*.gz' --exclude='*' --remove-source-files "$DIR_ORIGEN" "$DIR_DESTINO" && \
echo -e "\nSincronizando archivos .log..." && sudo rsync -rzPH --no-perms --include='*/' --include='*.log' --exclude='*' "$DIR_ORIGEN" "$DIR_DESTINO" && \
echo -e "\nLimpiando archivos .log de mas de 100MB..." && for flog in $(find "$DIR_ORIGEN" -type f -name "*.log" -size +100M); do sudo echo '' > "$flog"; done && \
echo -e "\nComprimiendo archivos .log de mas de 100MB..." && tar cf - "$DIR_DESTINO" | pv | gzip > "$DIR_DESTINO.tar.gz" && rm -r "$DIR_DESTINO" && \
sudo umount "$DIR_LOCAL" && \
echo -e "\nTodas las tareas terminadas."
```
## Desglose paso a paso.

- Limpia la pantalla del terminal y continúa con el siguiente comando:
  ```bash
  clear && \
  ```

- Establece la variable `DIR_ORIGEN` con el valor "/var/log" y solicita al usuario que ingrese un nuevo valor para el directorio origen. Si no se ingresa nada, se mantiene el valor por defecto:
  ```bash
  DIR_ORIGEN="/var/log" && read -p -e "\nIngresa el directorio ORIGEN [$DIR_ORIGEN]: " new_input && DIR_ORIGEN=${new_input:-$DIR_ORIGEN} && \
  ```

- Crea la variable `NOM_DIR_BKP` con un nombre de respaldo basado en el nombre del host y la fecha actual en formato "bkplogs_NOMBREDELHOST_AAAAMMDD_HHMM". Establece la variable `DIR_LOCAL` con el directorio local de respaldo utilizando el nombre generado:
  ```bash
  NOM_DIR_BKP="bkplogs_$(hostname)_$(date +"%Y%m%d_%H%M")" && DIR_LOCAL="/mnt/$NOM_DIR_BKP" && \
  ```

- Establece la variable `DST_USR` con el valor del usuario actual y solicita al usuario que ingrese un nuevo valor para el usuario de destino en el equipo remoto. Si no se ingresa nada, se mantiene el valor por defecto:
  ```bash
  DST_USR=$(whoami) && read -p "Ingresa el USUARIO para conectar en el pc destino[$DST_USR]: " new_input && DST_USR=${new_input:-$DST_USR} && \
  ```

- Establece la variable `DST_IP` con el valor "10.0.10.17" y solicita al usuario que ingrese una nueva dirección IP de destino. Si no se ingresa nada, se mantiene el valor por defecto:
  ```bash
  DST_IP="10.0.10.17" && read -p -e "\nIngresa la IP destino[$DST_IP]: " new_input && DST_IP=${new_input:-$DST_IP} && \
  ```

- Establece la variable `DIR_REMOTO` con el valor "/home/rmonla/bkp/" y solicita al usuario que ingrese un nuevo valor para el directorio de destino en el equipo remoto. Si no se ingresa nada, se mantiene el valor por defecto:
  ```bash
  DIR_REMOTO="/home/rmonla/bkp/" && read -p -e "\nIngresa el directorio DESTINO [$DIR_REMOTO]: " new_input && DIR_REMOTO=${new_input:-$DIR_REMOTO} && \
  ```

- Crea la variable `HOST` concatenando el valor de `DST_USR` y `DST_IP`. Actualiza la variable `DIR_REMOTO` agregando el valor de `HOST` y `DIR_REMOTO` separados por ":":
  ```bash
  HOST="$DST_USR@$DST_IP" && DIR_REMOTO="$HOST:$DIR_REMOTO" && \
  ```
- Muestra un mensaje indicando que se está montando la ubicación remota (`$DIR_REMOTO`), crea el directorio local (`$DIR_LOCAL`) si no existe y utiliza `sshfs` para montar la ubicación remota en el directorio local:
  ```bash
  echo -e "\nMontando $DIR_REMOTO..." && sudo mkdir -p "$DIR_LOCAL" && sudo sshfs -o allow_other "$DIR_REMOTO" "$DIR_LOCAL" && \
  ```

- Establece la variable `DIR_DESTINO` como la ruta completa del directorio de destino en el directorio local:
  ```bash
  DIR_DESTINO="$DIR_LOCAL/$NOM_DIR_BKP" && \
  ```

- Muestra un mensaje indicando que se están sincronizando los archivos con extensión `.gz` desde `$DIR_ORIGEN` a `$DIR_DESTINO` utilizando `rsync`. Se asegura de mantener la estructura de directorios (`*/`) y excluye todos los demás archivos. También se eliminan los archivos fuente después de la sincronización:
  ```bash
  echo -e "\nSincronizando archivos .gz..." && sudo rsync -rzPH --no-perms --include='*/' --include='*.gz' --exclude='*' --remove-source-files "$DIR_ORIGEN" "$DIR_DESTINO" && \
  ```

- Muestra un mensaje indicando que se están sincronizando los archivos con extensión `.log` desde `$DIR_ORIGEN` a `$DIR_DESTINO` utilizando `rsync`. Se asegura de mantener la estructura de directorios (`*/`) y excluye todos los demás archivos:
  ```bash
  echo -e "\nSincronizando archivos .log..." && sudo rsync -rzPH --no-perms --include='*/' --include='*.log' --exclude='*' "$DIR_ORIGEN" "$DIR_DESTINO" && \
  ```

- Muestra un mensaje indicando que se están limpiando los archivos `.log` que tienen un tamaño superior a 100 MB. Recorre todos los archivos `.log` que cumplen con esta condición y los vacía:
  ```bash
  echo -e "\nLimpiando archivos .log de más de 100MB..." && for flog in $(find "$DIR_ORIGEN" -type f -name "*.log" -size +100M); do sudo echo '' > "$flog"; done && \
  ```

- Muestra un mensaje indicando que se están comprimiendo los archivos en el directorio `$DIR_DESTINO` que tienen un tamaño superior a 100 MB. Utiliza `tar` y `gzip` para crear un archivo comprimido `.tar.gz`, muestra el progreso utilizando `pv` y elimina el directorio `$DIR_DESTINO` después de la compresión:
  ```bash
  echo -e "\nComprimiendo archivos .log de más de 100MB..." && tar cf - "$DIR_DESTINO" | pv | gzip > "$DIR_DESTINO.tar.gz" && rm -r "$DIR_DESTINO" && \
  ```
- Desmonta la ubicación remota `$DIR_LOCAL` utilizando el comando `umount`:
  ```bash
  sudo umount "$DIR_LOCAL" && \
  ```

- Muestra un mensaje indicando que todas las tareas han terminado:
  ```bash
  echo -e "\nTodas las tareas terminadas."
  ```
