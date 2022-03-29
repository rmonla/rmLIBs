# rmLIBs - Linux - Repositorios

## [Buscar el repositorio más rápido para tu debian](https://bantics.com.ar/buscar-el-repositorio-mas-rapido-para-tu-debian/)

Existe un par de herramienta para debian que nos ayuda a buscar los repositorios mas veloces para nuestra zona y conexion de internet y poder configurar mejor nuestros repositorios:

## netselect 
    sudo apt install netselect

Permite realizar pruebas de velocidad.

    sudo netselect -vv http://ftp.br.debian.org/debian/ http://ftp.us.debian.org/debian/

## Instalar Sudo.
    # apt-get update && apt-get
    # apt install sudo

## Agregar usuario para que use sudo.
    usermod -aG sudo USERNAME

Cerrar sesión o re-ingresar para los cambios tengan efecto.
