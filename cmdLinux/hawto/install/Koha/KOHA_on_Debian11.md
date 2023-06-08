
# Cómo instalar KOHA en Debian 11

## ¿Qué es Koha? 
Koha es una plataforma de gestión de bibliotecas de código abierto ampliamente utilizada en todo el mundo. Fue originalmente desarrollada en Nueva Zelanda y se ha convertido en una de las soluciones más populares para bibliotecas de cualquier tamaño.

## Introducción y recomendaciones:

Este script ha sido creado para estandarizar un modelo de instalación para el ámbito de la Universidad Tecnológica Nacional en Argentina.Se asume que los usuarios tienen un conocimiento básico de comandos de Linux.  
El objetivo es instalar el sistema Koha en un servidor Debian 11 "bullseye" con una instalación limpia y con los paquetes SSH y sudo como requisitos mínimos.  
Se recomienda disponer de al menos 2 GB de memoria y 32 GB de espacio en disco.
Agradecemos cualquier aporte o sugerencia.  

Atte.  
Lic. Ricardo MONLA  
rmonla@frlr.utn.edu.ar  
TIC - UTN FR La Rioja  

- Versión: 1.5
- GitHub: [KOHA_on_Debian11](https://github.com/rmonla/rmLIBs/blob/master/cmdLinux/howto/install/Koha/KOHA_on_Debian11.md)


## Paso a Paso.

1. Actualizar el sistema.

```bash
clear && \
sudo apt update -y && sudo apt full-upgrade -y && \
[ -f /var/run/reboot-required ] && sudo reboot
```
2. Importar una clave pública desde un servidor de claves de Ubuntu/Debian.

```bash
clear && \
sudo apt install gnupg -y && \
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3C9356BBA2E41F10
```
3. Actualizar el nombre del host. (Opcional)

```bash
clear && \
H_ACTUAL=$(hostname) && \
read -p "Ingresa el nuevo nombre de host: " H_NUEVO && \
sudo sed -i "s/$H_ACTUAL/$H_NUEVO/g" /etc/hosts /etc/hostname && \
sudo reboot
```
4. Configurar repositorio e instalar KOHA.

```bash
clear && \
echo "deb http://debian.koha-community.org/koha oldstable main" | sudo tee /etc/apt/sources.list.d/koha.list && \
sudo apt update -y && \
sudo apt install koha -y
```
5. Establecer el PUERTO de Apache y Koha. (Se recomienda '8080')

```bash
clear && \
read -p 'Ingrese el nuevo puerto: ' K_PORT && \
CFG_ARCH="/etc/apache2/ports.conf" && \
OLD_PORT=$(grep -oP '^Listen\s+\K\d+' "$CFG_ARCH") && \
sudo sed -i "s/Listen $OLD_PORT/Listen $S_PORT/" "$CFG_ARCH" && \
CFG_ARCH="/etc/koha/koha-sites.conf" && \
OLD_PORT=$(grep -oP 'INTRAPORT="\K[^"]+' "$CFG_ARCH") && \
sudo sed -i "s/INTRAPORT=\"$OLD_PORT\"/INTRAPORT=\"$K_PORT\"/" "$CFG_ARCH" && \
sudo a2enmod rewrite && \
sudo a2enmod cgi && \
sudo systemctl reload apache2 && \
sudo systemctl restart apache2
```
6. Crear la base de datos de la Bibliota. (Ejemplo 'utnlr')

```bash
clear && \
read -p 'Ingrese el nombre de la Biblioteca: ' NOM_BIBLIOTECA && \
sudo koha-create --create-db "$NOM_BIBLIOTECA"
```
7. Desactivar el sitio por defecto de apache, agregar el nuevo koha y reiniciar apache.

```bash
clear && \
sudo a2dissite 000-default && sudo a2enmod deflate && \
sudo a2ensite $NOM_BIBLIOTECA && sudo service apache2 restart
sudo service memcached restart 
```
8. Instalar la traduccion al español.

```bash
clear && \
sudo koha-translate --install es-ES 
```
9. Continuar instalación por Web.

```bash
clear && \
K_IP=$(hostname -I | awk '{for(i=1; i<=NF; i++) if($i ~ /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/) printf "%s#", $i}' | sed 's/#$//') && \
K_PORT=$(grep -oP 'INTRAPORT="\K[^"]+' /etc/koha/koha-sites.conf) && \
K_USER=$(sudo xmlstarlet sel -t -v "//config/user" /etc/koha/sites/utnlr/koha-conf.xml) && \
K_PASS=$(sudo xmlstarlet sel -t -v "//config/pass" /etc/koha/sites/utnlr/koha-conf.xml) && \
echo -e "Ahora debes continuar instalando desde la web.\nIngresa a http://$K_IP:$K_PORT\ncon el Usuario >> $K_USER << y contraseña >> $K_PASS <<"
```
