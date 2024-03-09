# Instalar y Optimizar MariaDB en Ubuntu.
![Estado: EnProceso](https://img.shields.io/badge/Estado-EnProceso-brightgreen)
![Versión: 1.5](https://img.shields.io/badge/Versión-1.5-blue)
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
sudo add-apt-repository 'deb [arch=amd64,arm64,ppc64el] https://mariadb.mirror.liquidtelecom.com/repo/10.11/ubuntu focal main'
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
```
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'secret_password';
```
```
GRANT ALL PRIVILEGES ON *.* TO 'admin_user'@'localhost';
```
```
FLUSH PRIVILEGES;
```
```
EXIT;
```

8. **Verifico los datos de ususario admin.**
```
sudo mariadb -u admin_user -p
```
```
SHOW DATABASES;
```
```
CREATE DATABASE test_db;
```
```
SHOW DATABASES;
```
```
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
```
```
SELECT host, useR FROM mysql.user;
```
```
+-----------+-------------+
| Host      | User        |
+-----------+-------------+
| localhost | admin_user  |
| localhost | mariadb.sys |
| localhost | mysql       |
| localhost | root        |
+-----------+-------------+
4 rows in set (0,005 sec)
```
```
FLUSH PRIVILEGES;
```
```
QUIT;
```
## Optimización y mejoras de Performance.

 - **Estimar la cantidad de IOPS (operaciones de entrada/salida por segundo).**
```
sudo mariadb -u admin_user -p
```
```
SELECT CEILING(Total_InnoDB_Bytes*1.6/POWER(1024,3)) RIBPS FROM
(SELECT SUM(data_length+index_length) Total_InnoDB_Bytes
FROM information_schema.tables WHERE engine='InnoDB') A;
```
```
+-------+
| RIBPS |
+-------+
|     1 |
+-------+
1 row in set (0,041 sec)
```
```
QUIT;
```
Esta consulta proporciona una estimación inicial de los IOPS necesarios para manejar la lectura y escritura de datos en las tablas InnoDB de tu base de datos MySQL, teniendo en cuenta el tamaño total de los datos e índices.

 - **Especificar el máximo numero de conecciones.**
```
sudo mariadb -u admin_user -p
```
```
set global max_connections=500;
```
```
flush privileges;
```
```
exit;
```

 - **Configuro uso de memoria y no del disco.**
```
sudo sysctl -w vm.swappiness=0
```
 Este comando puede ser útil para mejorar el rendimiento de tu sistema si tiene suficiente memoria RAM. Sin embargo, es importante usarlo con precaución y monitorizar el uso de la memoria de tu sistema.

### **Modificar parámetros del archivo de configuración de MariaDB**
```
sudo nano /etc/mysql//mariadb.conf.d/50-server.cnf
```
1. Descomentar #skip-name-resolve 
```
skip-name-resolve
```
La variable `skip-name-resolve` se utiliza en el servidor de base de datos MySQL para deshabilitar la resolución de nombres de host durante las conexiones de clientes. En otras palabras, en lugar de utilizar el nombre de host proporcionado por el cliente para conectarse, MySQL solo considerará la dirección IP para la autorización y el control de acceso.

2. Descomentar y modificar #innodb_buffer_pool_size = 8G.
```
innodb_buffer_pool_size = 1G
```
La variable `innodb_buffer_pool_size` es una de las variables más importantes para optimizar el rendimiento de MySQL. Se refiere al tamaño del buffer pool de InnoDB, que es un área de memoria que InnoDB utiliza para almacenar datos y índices en caché.

3. Agregar al final del archivo luego de la línea `[mariadb-10.xx]`
```
query_cache_size = 64M
wait_timeout = 60
slow-query-log = 1
slow-query-log-file = /var/lib/mysql/mysql-slow.log
long_query_time = 1
```
| Parámetro | Función | Efecto | Consideraciones |
|---|---|---|---|
| query_cache_size | Controla el tamaño de la memoria caché de consultas. | Almacena resultados de consultas pre-ejecutadas, mejorando el rendimiento. | Ajustar según carga de trabajo y memoria RAM. |
| wait_timeout | Define el tiempo máximo de espera de una respuesta del servidor. | Protege el servidor de conexiones sin respuesta. | Ajustar según carga de trabajo y latencia de red. |
| slow-query-log | Activa el registro de consultas que tardan más de `long_query_time`. | Permite identificar consultas que causan bajo rendimiento. | Puede generar un gran volumen de datos de registro. |
| slow-query-log-file | Define la ubicación del archivo de registro de consultas lentas. | Permite personalizar la ubicación y el nombre del archivo. | Asegurar permisos de escritura para el usuario de MySQL. |
| long_query_time | Define el tiempo en segundos que una consulta tarda para ser considerada "lenta". | Permite ajustar el umbral para el registro de consultas lentas. | Ajustar según carga de trabajo y tolerancia a la latencia. |

En resumen, estos parámetros te permiten optimizar el rendimiento de MySQL al controlar la memoria caché de consultas, las conexiones inactivas, el registro de consultas lentas y el umbral para considerar una consulta como "lenta".

 - Grabar y reiniciar MariaDB.
```
sudo systemctl restart mariadb
```
