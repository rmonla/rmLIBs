# MaySQL Server

![Estado: Operativo](https://img.shields.io/badge/Estado-Operativo-brightgreen)
![Versión: 1.2](https://img.shields.io/badge/Versión-1.2-blue)
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


B). [**How To Install MySQL on Ubuntu 20.04**](https://www.devart.com/dbforge/mysql/how-to-install-mysql-on-ubuntu/](https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-20-04))

  1. Instalar el paquete mysql-server:
~~~bash
sudo apt install mysql-server -y
~~~
  2. Inicio el srvicio.
~~~bash
sudo systemctl start mysql.service
~~~

### La instalación se probó con éxito y funcionó en Ubuntu Server 22.
