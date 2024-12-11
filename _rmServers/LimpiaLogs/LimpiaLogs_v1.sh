clear && \
DIR_ORIGEN="/var/log/" && read -p -e "\nIngresa el directorio ORIGEN ['$DIR_ORIGEN']: " new_input && DIR_ORIGEN=${new_input:-$DIR_ORIGEN} && \
NOM_DIR_BKP="bkplogs_$(hostname)_$(date +'%Y%m%d_%H%M')" && DIR_LOCAL="/mnt/$NOM_DIR_BKP" && \
DST_USR=$(whoami) && read -p $'Ingresa el USUARIO para conectar en el pc destino ['$DST_USR']: ' new_input && DST_USR=${new_input:-$DST_USR} && \
DST_IP="10.0.10.17" && read -p -e $'\nIngresa la IP destino ['$DST_IP']: ' new_input && DST_IP=${new_input:-$DST_IP} && \
DIR_REMOTO="/home/rmonla/bkp/" && read -p -e $'\nIngresa el directorio DESTINO ['$DIR_REMOTO']: ' new_input && DIR_REMOTO=${new_input:-$DIR_REMOTO} && \
HOST="$DST_USR@$DST_IP" && DIR_REMOTO="$HOST:$DIR_REMOTO" && \
echo -e $'\nMontando $DIR_REMOTO...' && \
sudo mkdir -p "$DIR_LOCAL" && \
sudo sshfs -o allow_other "$DIR_REMOTO" "$DIR_LOCAL" && \
DIR_DESTINO="$DIR_LOCAL/$NOM_DIR_BKP" && \
echo -e $'\nSincronizando archivos .log y .gz...' && sudo rsync -avz --include='*.log' --include='*.gz' --exclude='*' "$DIR_ORIGEN" "$DIR_DESTINO" && \
echo -e $'\nEliminando archivos .gz...' && sudo find "$DIR_ORIGEN" -type f -name "*.gz" -delete && \
echo -e $'\nLimpiando archivos .log de más de 100MB...' && sudo find "$DIR_ORIGEN" -type f -name "*.log" -size +100M -exec sudo echo '' > {} \; && \
echo -e $'\nComprimiendo archivos .log de más de 100MB...' && tar cf - "$DIR_DESTINO" | pv | gzip > "$DIR_DESTINO.tar.gz" && rm -r "$DIR_DESTINO" && \
sudo umount "$DIR_LOCAL" && \
echo -e $'\nTodas las tareas terminadas.'



sudo rsync -avz --include='*.log' --include='*.gz' --exclude='*' '/var/log/' "$DIR_DESTINO" 


clear && \
ORIGEN="/var/log/" && \
read -p $'\nIngresa el directorio ORIGEN ['$ORIGEN']: ' new && ORIGEN=${new:-$ORIGEN} && \
DST_USR=$(whoami) && \
read -p $'Ingresa el USUARIO para conectar en el pc destino ['$DST_USR']: ' new && DST_USR=${new:-$DST_USR} && \
DST_IP="10.0.10.17" && \
read -p $'\nIngresa la IP destino ['$DST_IP']: ' new && DST_IP=${new:-$DST_IP} && \
DST_DIR="/home/rmonla/bkp/" && \
read -p $'\nIngresa el directorio DESTINO ['$DST_DIR']: ' new && DST_DIR=${new_input:-$DST_DIR} && \
NOM_DIR_DST="bkplogs_$(hostname)_$(date +'%Y%m%d_%H%M')" && \
DST_DIR="$DST_DIR$NOM_DIR_DST" && \
mkdir -p "$DST_DIR" && \
HOST="$DST_USR@$DST_IP" && \
DESTINO="$HOST:$DST_DIR" && \
echo -e "
rsync -avzP --include='*/' --include='*.log' --include='*.gz' --include='messages' --include='syslog' --exclude='*' $ORIGEN $DESTINO && for file in \$(find /var/log -type f -size +1G); do echo -e \"Limpiando \$file...\" && sudo echo '' > \"\$file\"; done"

for file in $(find /var/log -type f -size +1G); do echo -e "Limpiando $file..." && sudo echo '' > "$file"; done



clear && \
ORIGEN="/var/log/" && \
DST_USR=$(whoami) && \
DST_IP="10.0.10.17" && \
DST_DIR="/home/rmonla/bkp/" && \
NOM_DIR_DST="bkplogs_$(hostname)_$(date +'%Y%m%d_%H%M')" && \
DST_DIR="$DST_DIR$NOM_DIR_DST" && \
mkdir -p "$DST_DIR" && \
HOST="$DST_USR@$DST_IP" && \
DESTINO="$HOST:$DST_DIR" && \
echo -e "
rsync -avzP --include='*/' --include='*.log' --include='*.gz' --include='messages' --include='syslog' --exclude='*' $ORIGEN $DESTINO && for file in \$(find /var/log -type f -size +1G); do echo -e \"Limpiando \$file...\" && sudo echo '' > \"\$file\"; done"

for file in $(find /var/log -type f -size +1G); do echo '' > "$file"; done






for file in /var/log/messages /var/log/syslog /var/log/syslog; do echo '' > "$file"; done
for file in $(find /var/log -type f -size +1G); do echo -e "\nLimpiando $file..." && echo '' > "$file"; done


sudo rsync -avzP --include='*.log' --include='*.gz' --include='messages' --include='syslog' --exclude='*' /var/log/ rmonla@10.0.10.17:/home/rmonla/bkp/

sudo find "/var/log/" -type f -name "*.log" -size +100M -exec sudo echo '' > {} \;


watch -n 1 'du -h -d 1 /var/log | awk '\''$1~/[0-9]+M/ && $1>"100M" {print}'\'
watch -n 1 'find /var/log/ -type f -size +100M -exec ls -lah {} \; && {print}'\'
watch -n 1 'find /var/log/ -type f -size +100M -exec ls -lah {} \;'\'

find /var/log/ -type f -size +100M -exec ls -lah {} \;

