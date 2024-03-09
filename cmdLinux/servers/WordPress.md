# WordPress en Ubuntu 20.
![Estado: EnProceso](https://img.shields.io/badge/Estado-EnProceso-brightgreen)
![Versión: 0.1](https://img.shields.io/badge/Versión-0.1-blue)
[![Autor: Lic. Ricardo MONLA](https://img.shields.io/badge/Autor-Lic.%20Ricardo%20MONLA-orange)](mailto:rmonla@frlr.utn.edu.ar)

## Preparación
- [Linux Actualización y Mantenimiento.](https://github.com/rmonla/rmLIBs/blob/master/cmdLinux/Linux%20Actualizaci%C3%B3n%20y%20Mantenimiento.md)
    - Actualizar del sistema.
    - Cambiar el nombre del host.

## Instalación
- [Instalar y Optimizar MariaDB en Ubuntu.](https://github.com/rmonla/rmLIBs/blob/master/cmdLinux/servers/MariaDB%20en%20Ubuntu.md)
    - Se realizan los pasos incluida la optimización.
- Instalar Apache y PHP.
```
sudo apt install -y apache2 php php-{common,mysql,xml,xmlrpc,curl,gd,imagick,cli,dev,imap,mbstring,opcache,soap,zip,intl}
```
- Habilitar e iniciar el Apache.
```
sudo systemctl enable apache2
```
Verificar de funcionamiento del servicio.
```
systemctl status apache2
```

## Fuentes consultadas
- [How to Install WordPress on Ubuntu 22.04 LTS Server](https://linux.how2shout.com/how-to-install-wordpress-on-ubuntu-22-04-lts-server/)
