# Kasperky Security Center en Ubuntu.
![Estado: EnProceso](https://img.shields.io/badge/Estado-EnProceso-brightgreen)
![Versión: 1.3](https://img.shields.io/badge/Versión-1.3-blue)
[![Autor: Lic. Ricardo MONLA](https://img.shields.io/badge/Autor-Lic.%20Ricardo%20MONLA-orange)](mailto:rmonla@frlr.utn.edu.ar)

Fuente: 
- [Instalación de Kaspersky Security Center Linux](https://support.kaspersky.com/ksclinux/14.2/es-MX/166764.htm)
- [Configurar el servidor MariaDB x64 para trabajar con Kaspersky Security Center Linux](https://support.kaspersky.com/ksclinux/14.2/es-MX/210277.htm)


## Preparación
- *Actualización del sistema*
```bash
sudo apt update -y && sudo apt full-upgrade  -y && [ -f /var/run/reboot-required ] && sudo reboot -f
```

- *Actualizar el nombre del host (opcional)*
```bash
clear && \
H_ACTUAL=$(hostname) && \
read -p "Ingresa el nuevo nombre de host: " H_NUEVO && \
sudo sed -i "s/$H_ACTUAL/$H_NUEVO/g" /etc/hosts /etc/hostname && \
sudo reboot
```
## Instalación
- *Instalar MariaDB*
  + [Como Instalar MariaDB en Ubuntu](https://github.com/rmonla/rmLIBs/tree/master/cmdLinux/servers/MariaDB)
  + [Configuración de la cuenta de DBMS para trabajar con MySQL y MariaDB](https://support.kaspersky.com/ksclinux/14.2/es-MX/240816.htm)
    * Ingrese a DBMS con una cuenta de admminitración.
    ```
    sudo mariadb -u admin_user -p
    ```
    * Cree una cuenta interna para el instalador del Servidor de administración.
    ```
    /* Crear un usuario llamado KSCAdmin y definir la contraseña de KSCAdmin */
    CREATE USER 'KSCAdmin' IDENTIFIED BY '<contraseña>';
    ```
    * Otorgar privilegios.
    ```
    /* Otorgar privilegios a KSCAdmin */
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
    /* Crear BD kav */
    CREATE DATABASE kav
    DEFAULT CHARACTER SET utf8
    DEFAULT COLLATE utf8_general_ci;
    ```
  + [Instale el Servidor de administración](https://support.kaspersky.com/ksclinux/14.2/es-MX/166764.htm)
