# Cómo instalar KOHA en Debian 11 "bullseye"

Fuente: [Instalacion_Rapida_de_KOHA.pdf](./Instalacion_Rapida_de_KOHA.pdf)

Koha es una plataforma de gestión de bibliotecas de código abierto que se utiliza en todo el mundo. Fue desarrollada originalmente en Nueva Zelanda y se ha convertido en una de las soluciones más populares para bibliotecas de todos los tamaños.

1. Actualizar el nombre del host.

```bash
clear && \
antiguo_nombre=$(hostname) && \
read -p "Ingresa el nuevo nombre de host: " nuevo_nombre && \
sudo sed -i "s/$antiguo_nombre/$nuevo_nombre/g" /etc/hosts /etc/hostname && \
sudo reboot
```

2. Actualizar el sistema.

```bash
clear && \
sudo apt update -y && sudo apt full-upgrade -y && \
[ -f /var/run/reboot-required ] && sudo reboot
```

3. Importar una clave pública desde un servidor de claves de Ubuntu/Debian.

```bash
clear && \
sudo apt install gnupg -y && \
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3C9356BBA2E41F10
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
clear && \
sudo apt install apache2 mariadb-server koha-common nano -y
```

6. Establecer contraseña para el usuario 'root' del servidor MariaDB.

```bash
clear && \
read -s -p 'Ingrese la nueva contraseña de root: ' newpass && \
echo $newpass | sudo mysqladmin -u root password --stdin
```

7. Establecer el nuevo puerto de la configuracion de Koha y reiniciar el servidor apache. (Se recomienda '8080').

```bash
clear && \
CFG_ARCH="/etc/koha/koha-sites.conf" && \
OLD_PORT=$(grep -oP 'INTRAPORT="\K[^"]+' "$CFG_ARCH") && \
read -p 'Ingrese el nuevo puerto: ' NEW_PORT && \
sudo sed -i "s/INTRAPORT=\"$OLD_PORT\"/INTRAPORT=\"$NEW_PORT\"/" "$CFG_ARCH" && \
sudo a2enmod rewrite && \
sudo a2enmod cgi && \
sudo systemctl reload apache2 && \
sudo systemctl restart apache2
```

8. Crear la base de datos de la Bibliota de la Facultad. (Ejemplo 'utnlr-koha').

```bash
clear && \
read -p 'Ingrese el nombre de la Biblioteca: ' NOM_BIBLIOTECA && \
sudo koha-create --create-db "$NOM_BIBLIOTECA"
```

9. Establecer el nuevo puerto de la configuracion de Apache y reiniciar el servidor apache. (Se recomienda '8080').

```bash
clear && \
CFG_ARCH="/etc/apache2/ports.conf" && \
OLD_PORT=$(grep -oP '^Listen\s+\K\d+' "$CFG_ARCH") && \
read -p 'Ingrese el nuevo puerto: ' NEW_PORT && \
sudo sed -i "s/Listen $OLD_PORT/Listen $NEW_PORT/" "$CFG_ARCH" && \
sudo systemctl reload apache2 && \
sudo systemctl restart apache2
```

10. Desactivar el sitio por defecto de apache, agregar el nuevo koha y reiniciar apache.

```bash
clear && \
sudo a2dissite 000-default && sudo a2enmod deflate && \
sudo a2ensite $NOM_BIBLIOTECA && sudo service apache2 restart
sudo service memcached restart 
```


***FALTAAAA 
cat /etc/koha/sites/$NOM_BIBLIOTECA/koha-conf.xml

grep -oP '<config>\s*<user>\K[^<]+' /etc/koha/sites/$NOM_BIBLIOTECA/koha-conf.xml && \
grep -oP '<config>\s*<pass>\K[^<]+' /etc/koha/sites/$NOM_BIBLIOTECA/koha-conf.xml


<config>
 <db_scheme>mysql</db_scheme>
 <database>koha_utnlr-koha</database>
 <hostname>localhost</hostname>
 <port>3306</port>
 <user>koha_utnlr-koha</user>
 <pass>79plY0*111#</pass>
</config>
<config2>
 <db_scheme>mysql</db_scheme>
 <database>koha_222</database>
 <hostname>localhost</hostname>
 <port>3306</port>
 <user>koha_222</user>
 <pass>79plY0*222#</pass>
<config2>





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
