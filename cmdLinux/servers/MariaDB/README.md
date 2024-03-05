# Como Instalar MariaDB en Ubuntu.
![Estado: EnProceso](https://img.shields.io/badge/Estado-EnProceso-brightgreen)
![Versión: 1.2](https://img.shields.io/badge/Versión-1.2-blue)
[![Autor: Lic. Ricardo MONLA](https://img.shields.io/badge/Autor-Lic.%20Ricardo%20MONLA-orange)](mailto:rmonla@frlr.utn.edu.ar)

Fuente: 
- [How to install MariaDB on Ubuntu](https://www.cherryservers.com/blog/how-to-install-and-start-using-mariadb-on-ubuntu-20-04)
 
- [How to Install and Start Using MariaDB on Ubuntu 20.04 | Step-by-Step](https://www.cherryservers.com/blog/how-to-install-and-start-using-mariadb-on-ubuntu-20-04)
- [How to Install MariaDB on Ubuntu [and Start Using it] Step-by-Step](https://youtu.be/QfViwTqYOGY?si=hGqxjPVp_waqs22e)


## Instalación

1. **Primero, instala el paquete de requisitos previos.**

```
sudo apt install -y software-properties-common
```

2. **A continuación, importa la clave de firma GPG.**

```
sudo apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc'
```

3. **Una vez que la clave GPG esté en su lugar, agrega el repositorio APT de MariaDB. El siguiente repositorio está habilitado para la versión 10.6 de MariaDB. Puedes reemplazar este valor con la versión que deseas instalar.**

```
sudo add-apt-repository 'deb [arch=amd64,arm64,ppc64el] https://mariadb.mirror.liquidtelecom.com/repo/10.6/ubuntu focal main'
```

4. **Finalmente, actualiza los repositorios locales e instala el servidor y el cliente de MariaDB utilizando el administrador de paquetes APT.**

```
sudo apt update && sudo apt install -y mariadb-server mariadb-client
```
5. **Ver versión instalada y estado del servicio.**
```
mariadb --version
```
```
sudo systemctl status mariadb
```
6. **Mejorar configuración de seguridad.**

```
sudo mysql_secure_installation
```
 - Enter current password for root (enter for none): ENTER
 - Switch to unix_socket authentication [Y/n]: n
 - Change the root password? [Y/n]: Y
   - PASSWORD 
 - Remove anonymous users? [Y/n] Y
 - Disallow root login remotely? [Y/n] Y
 - Remove test database and access to it? [Y/n] Y
 - Reload privilege tables now? [Y/n] Y
 - 

7. **Privilegios de Usuario.**

```
sudo mariadb -u root -p
```
 - CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'secret_password';
 - GRANT ALL PRIVILEGES ON *.* TO 'admin_user'@'localhost';
 - FLUSH PRIVILEGES;
 - EXIT;

8. **Verifico los datos de ususario admin.**
```
sudo mariadb -u admin_user -p
PASSWORD
SHOW DATABASES;
CREATE DATABASE test_db;
SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| test_db            |
+--------------------+
5 rows in set (0,001 sec)
FLUSH PRIVILEGES;
SELECT host, useR FROM mysql.user;
+-----------+-------------+
| Host      | User        |
+-----------+-------------+
| localhost | admin_user  |
| localhost | mariadb.sys |
| localhost | mysql       |
| localhost | root        |
+-----------+-------------+
4 rows in set (0,005 sec)
QUIT
```
9. **Configurar MariaDB para una Performance óptima.**
```
sudo mariadb -u admin_user -p
PASSWORD

SELECT CEILING(Total_InnoDB_Bytes*1.6/POWER(1024,3)) RIBPS FROM
(SELECT SUM(data_length+index_length) Total_InnoDB_Bytes
FROM information_schema.tables WHERE engine='InnoDB') A;
+-------+
| RIBPS |
+-------+
|     1 |
+-------+
1 row in set (0,041 sec)
QUIT
```
```
sudo nano /etc/mysql//mariadb.conf.d/50-server.cnf
```
Descomentar y modificar 
#innodb_buffer_pool_size = 8G

innodb_buffer_pool_size = 1G

Grabar y guardar
5 rows in set (0,001 sec)
FLUSH PRIVILEGES;
SELECT host, useR FROM mysql.user;
+-----------+-------------+
| Host      | User        |
+-----------+-------------+
| localhost | admin_user  |
| localhost | mariadb.sys |
| localhost | mysql       |
| localhost | root        |
+-----------+-------------+
4 rows in set (0,005 sec)
QUIT
```



 


