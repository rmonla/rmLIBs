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
sudo apt install apache2 mariadb-server koha-common -y
```

6. Establecer contraseña para el usuario 'root' del servidor MariaDB.

```bash
clear && \
echo "Nueva contraseña para el usuario 'root' del servidor MariaDB." && \
sudo mysqladmin -u root password 
```
7. Crear la base de datos de la Bibliota de la Facultad. (Ejemplo 'utnlr').

```bash
clear && \
read -p 'Ingrese el nombre de la Biblioteca: ' NOM_BIBLIOTECA && \
sudo koha-create --create-db "$NOM_BIBLIOTECA"
```

8. Establecer el nuevo puerto de la configuracion de Koha y reiniciar el servidor apache. (Se recomienda '8080').

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

11. Desactivar el sitio por defecto de apache, agregar el nuevo koha y reiniciar apache.

```bash
clear && \
sudo koha-translate --install es-ES 
```

12. Continuar instalación por Web.

```bash
clear && \
K_IP=$(hostname -I | awk '{for(i=1; i<=NF; i++) if($i ~ /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/) printf "%s#", $i}' | sed 's/#$//') && \
K_USER=$(sudo xmlstarlet sel -t -v "//config/user" /etc/koha/sites/utnlr/koha-conf.xml) && \
K_PASS=$(sudo xmlstarlet sel -t -v "//config/pass" /etc/koha/sites/utnlr/koha-conf.xml) && \
echo -e "Ahora debes continuar instalando desde la web.\nIngresa a http://$K_IP:8080\ncon el Usuario >> $K_USER << y contraseña >> $K_PASS <<"
```

# Comandos combinados.

```bash
clear 
```