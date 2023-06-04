# Cómo instalar KOHA en Debian 11 "bullseye"
Fuente: [How to install serviio dlna server on linux debian with ffmpeg and default-jre java howto](https://www.youtube.com/watch?v=99XzSTYO_Mw)

Koha es una plataforma de gestión de bibliotecas de código abierto que se utiliza en todo el mundo. Fue desarrollada originalmente en Nueva Zelanda y se ha convertido en una de las soluciones más populares para bibliotecas de todos los tamaños.

1. Actualizar el nombre del host.

```bash
clear && antiguo_nombre=$(hostname) && read -p "Ingresa el nuevo nombre de host: " nuevo_nombre && sudo sed -i "s/$antiguo_nombre/$nuevo_nombre/g" /etc/hosts /etc/hostname && sudo reboot
```

2. Actualizar el sistema.

```bash
clear && \
sudo apt update -y && sudo apt full-upgrade -y && \
[ -f /var/run/reboot-required ] && sudo reboot
```

3. Importar una clave pública desde un servidor de claves de Ubuntu/Debian.

```bash
clear && sudo apt install gnupg -y && sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3C9356BBA2E41F10
```

4. Configurar repositorio de KOHA y Actualizar el sistema.

```bash
clear && \
echo "deb http://debian.koha-community.org/koha oldstable main" | sudo tee /etc/apt/sources.list.d/koha.list && \
sudo apt update -y && sudo apt full-upgrade -y && \
[ -f /var/run/reboot-required ] && sudo reboot
```

5. Instalar los paquetes de software.

```bash
clear && sudo apt install apache2 mariadb-server koha-common nano -y
```

6. Establecer contraseña para el usuario 'root' del servidor MariaDB.

```bash
clear && read -s -p 'Ingrese la nueva contraseña de root: ' newpass && echo $newpass | sudo mysqladmin -u root password --stdin
```

7. Establecer el nuevo puerto y reiniciar el servidor apache. (Se recomienda '8080').

```bash
clear && \
CFG_ARCH="/etc/koha/koha-sites.conf" && \
ALL_PORT=$(grep -oP 'INTRAPORT="\K[^"]+' "$CFG_ARCH") && \
read -p 'Ingrese el nuevo puerto: ' NEW_PORT && \
sudo sed -i "s/INTRAPORT=\"$ALL_PORT\"/INTRAPORT=\"$NEW_PORT\"/" "$CFG_ARCH" && \
sudo a2enmod rewrite && \
sudo a2enmod cgi && \
sudo systemctl reload apache2 && \
sudo systemctl restart apache2
```

8. Crear la base de datos de la Bibliota de la Facultad. (Ejemplo 'utnlr-koha').

```bash
clear && \
read -p 'Ingrese el nombre de la base de datos: ' nomBDatos && \
sudo koha-create --create-db "$nomBDatos"
```






5. Conectarse por SSH con el usuario serviio.

```bash
read -p "Ingresa la IP del servidor Serviio: " IP_SERVIIO && \
ssh serviio@$IP_SERVIIO -> PASS_serviio
```

6. Descargar y descomprimir Serviio.

```bash
wget https://download.serviio.org/releases/serviio-2.3-linux.tar.gz && \
tar zxvf serviio-2.3-linux.tar.gz
```

7. Ejecutar Serviio en segundo plano.

```bash
screen -dmS serviio_run /home/serviio/serviio-2.3/bin/serviio.sh
```

8. Acceder por web.

```
http://IP_SERVIIO:23423/console/
```

# Comandos combinados.

```bash
clear && antiguo_nombre=$(hostname) && read -p "Ingresa el nuevo nombre de host: " nuevo_nombre && \
sudo sed -i "s/$antiguo_nombre/$nuevo_nombre/g" /etc/hosts /etc/hostname && \
sudo reboot

clear && sudo apt update -y && sudo apt full-upgrade -y && \
[ -f /var/run/reboot-required ] && sudo reboot

sudo apt install ffmpeg default-jre screen -y && \
sudo adduser serviio && exit 

read -p "Ingresa la IP del servidor Serviio: " IP_SERVIIO && \
ssh serviio@$IP_SERVIIO

wget https://download.serviio.org/releases/serviio-2.3-linux.tar.gz && \
tar zxvf serviio-2.3-linux.tar.gz && \
screen -dmS serviio_run /home/serviio/serviio-2.3/bin/serviio.sh && \
echo "Accede a: http://$IP_SERVIIO:23423/console/"
```

# Sería necesario consultar [Linux Daemon scripts](https://forum.serviio.org/viewtopic.php?f=4&t=71) para configurarlo como un servicio.
