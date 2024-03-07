# Kasperky Security Center en Ubuntu.
![Estado: EnProceso](https://img.shields.io/badge/Estado-EnProceso-brightgreen)
![Versión: 1.6](https://img.shields.io/badge/Versión-1.6-blue)
[![Autor: Lic. Ricardo MONLA](https://img.shields.io/badge/Autor-Lic.%20Ricardo%20MONLA-orange)](mailto:rmonla@frlr.utn.edu.ar)

## Preparación
- *Actualización del sistema*
```bash
sudo apt update -y && sudo apt full-upgrade  -y && [ -f /var/run/reboot-required ] && sudo reboot -f
```

- *Actualizar el nombre del host (opcional)*
```bash
clear && H_ACTUAL=$(hostname) && read -p "Ingresa el nuevo nombre de host: " H_NUEVO && sudo sed -i "s/$H_ACTUAL/$H_NUEVO/g" /etc/hosts /etc/hostname && sudo reboot
```
## Instalación de MariaDB y configurarla para KSC
- [Configurar el servidor MariaDB x64 para trabajar con Kaspersky Security Center Linux](https://support.kaspersky.com/ksclinux/14.2/es-MX/210277.htm)
    
  + [Como Instalar MariaDB en Ubuntu](https://github.com/rmonla/rmLIBs/tree/master/cmdLinux/servers/MariaDB)

  + [Configuración de la cuenta de DBMS para trabajar con MySQL y MariaDB](https://support.kaspersky.com/ksclinux/14.2/es-MX/240816.htm)
    * Ingresar con cuenta de admminitración.
    ```
    sudo mariadb -u root -p
    ```
    * Crear usuario KSCAdmin y definir su contraseña.
    ```
    CREATE USER 'KSCAdmin' IDENTIFIED BY '<contraseña>';
    ```
    * Otorgar privilegios a KSCAdmin.
    ```
    GRANT USAGE ON *.* TO 'KSCAdmin';
    GRANT ALL ON kav.* TO 'KSCAdmin';
    GRANT SELECT, SHOW VIEW ON mysql.* TO 'KSCAdmin';
    GRANT SELECT, SHOW VIEW ON sys.* TO 'KSCAdmin';
    GRANT EXECUTE ON PROCEDURE sys.table_exists TO 'KSCAdmin';
    GRANT PROCESS ON *.* TO 'KSCAdmin';
    GRANT SUPER ON *.* TO 'KSCAdmin';
    ```
    * Crear base de datos del Servidor de administración.
    ```
    CREATE DATABASE kav
    DEFAULT CHARACTER SET utf8
    DEFAULT COLLATE utf8_general_ci;
    ```
  + *Configurar el servidor MariaDB x64 para KSC*
    * Abrir archivo de configuración. 
    ```
    sudo nano /etc/mysql//mariadb.conf.d/50-server.cnf
    ```
    * Ingrese las siguientes líneas en la sección `[mysqld]` del archivo my.cnf: 
    ```
    sort_buffer_size=10M    
    join_buffer_size=100M    
    join_buffer_space_limit=300M    
    join_cache_level=8    
    tmp_table_size=512M    
    max_heap_table_size=512M    
    key_buffer_size=200M    
    innodb_buffer_pool_size=<valor>    
    innodb_thread_concurrency=20    
    innodb_flush_log_at_trx_commit=0    
    innodb_lock_wait_timeout=300    
    max_allowed_packet=32M    
    max_connections=151    
    max_prepared_stmt_count=12800    
    table_open_cache=60000    
    table_open_cache_instances=4    
    table_definition_cache=60000
    ```
    * Comprobar si los complementos optimizadores están habilitados o no:
      - En la consola cliente MariaDB, ejecute el comando:
      ```
      SELECT @@optimizer_switch;
      ```
      - Compruebe que la salida contenga las siguientes líneas:
      ```
      join_cache_incremental=on
      join_cache_hashed=on
      join_cache_bka=on
      ```
      Si estas líneas están presentes y tienen el valor on, quiere decir que están habilitados los complementos optimizadores.
      Si estas líneas faltan o tienen el valor off, haga lo siguiente:
      1. Abra el archivo `my.cnf` en un editor de texto.
      2. Agregue las siguientes líneas en el archivo `my.cnf`:
        ```
        optimizer_switch='join_cache_incremental=on'
        optimizer_switch='join_cache_hashed=on'
        optimizer_switch='join_cache_bka=on'
        ```
    * Reiniciar MariaDB.
    ```
    sudo systemctl restart mariadb
    ```

  + [Instale el Servidor de administración](https://support.kaspersky.com/ksclinux/14.2/es-MX/166764.htm)
    * Cree un grupo 'kladmins' y una cuenta sin privilegios 'ksc'. La cuenta debe ser miembro del grupo 'kladmins'. Para hacer esto, ejecute secuencialmente los siguientes comandos:
    ```
    sudo adduser ksc
    ```
    ```
    sudo groupadd kladmins
    ```
    ```
    sudo gpasswd -a ksc kladmins
    ```
    ```
    sudo usermod -g kladmins ksc
    ```
    ```
    sudo adduser ksc && sudo groupadd kladmins && sudo gpasswd -a ksc kladmins && sudo usermod -g kladmins ksc
    ```
    * Descargar el aplicativo:
      Buscar y descargar el módulo
        Kaspersky Security Center
      Version 15.0.0.12912 | Debian x64 | Administration server
      desde la direccion
      https://latam.kaspersky.com/small-to-medium-business-security/downloads/endpoint
    ```
    wget https://products.s.kaspersky-labs.com/administrationkit/ksc10/15.0.0.12912/spanish-15511518-es-MX/3739313830397c44454c7c31/ksc64_15.0.0-12912_amd64.deb
    ```
    * Instalar el aplicativo:
    ```
    sudo apt install ksc64_15.0.0-12912_amd64.deb
    ```    
  + [Instalación de Kaspersky Security Center Web Console](https://support.kaspersky.com/ksclinux/14.2/es-MX/181968.htm)
 
