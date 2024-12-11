# MaySQL Server

![Estado: Operativo](https://img.shields.io/badge/Estado-Operativo-brightgreen)
![Versión: 1.4](https://img.shields.io/badge/Versión-1.4-blue)
[![Autor: Lic. Ricardo MONLA](https://img.shields.io/badge/Autor-Lic.%20Ricardo%20MONLA-orange)](mailto:rmonla@frlr.utn.edu.ar)
--------------  

A). [ How To Install MySQL on Debian 12 ](https://idroot.us/install-mysql-debian-12/)

  1. Actualizar información de repositorios:
~~~bash
sudo apt update -y
~~~
  2. Instalar paquetes iniciales:
~~~bash
sudo apt install -y apt-transport-https lsb-release ca-certificates curl dirmngr gnupg lsb-release wget
~~~
  3. Descargo y despliego el configurador del repositorio.
~~~bash
wget https://dev.mysql.com/get/mysql-apt-config_0.8.18-1_all.deb && sudo dpkg -i mysql-apt-config_0.8.18-1_all.deb
~~~
  4. Actualizar información de repositorios e instalo.
~~~bash
sudo apt update -y && sudo apt install -y mysql-server mysql-client
~~~

### La instalación se probó con éxito y funcionó en Debian 12.

B). [PhpMyAdmin en Linux: instalación paso a paso](https://www.arsys.es/blog/instalar-phpmyadmin-linux)

  1. Instalar el aplicativo phpmyadmin:
~~~bash
sudo apt-get install -y phpmyadmin
~~~
  2. Reinicio el servidor apache.
~~~bash
sudo systemctl stop mysql.service && sudo systemctl start mysql.service
~~~
  3. Accedo por web al phpmyadmin.
  --> http://YOUR_SERVER_IP/phpmyadmin


C). [How to Install Webmin on Debian 12](https://www.howtoforge.com/how-to-install-webmin-on-debian-12/)

  1. Instalar aplcativos requeridos.
~~~bash
sudo apt install gnupg2 curl -y
~~~
  2. Descarga, agrega la clave GPG y añade el repositorio de Webmin.
~~~bash
curl -o setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh && sudo sh setup-repos.sh
~~~
  3. Actualizar el repositorio e instala Webmin.
~~~bash
sudo apt update -y && sudo apt install webmin --install-recommends -y
~~~
  4. Verificar el estado del servicio de Webmin.
~~~bash
service webmin status
~~~


### La instalación se probó con éxito y funcionó en Debian 12.
