# rmLIBs - Linux - Repositorios

## [Buscar el repositorio más rápido para tu debian](https://bantics.com.ar/buscar-el-repositorio-mas-rapido-para-tu-debian/)

Existe un par de herramienta para debian que nos ayuda a buscar los repositorios mas veloces para nuestra zona y conexion de internet y poder configurar mejor nuestros repositorios:

## netselect 
    $ sudo apt install netselect

Permite realizar pruebas de velocidad.

    $ sudo netselect -vv http://ftp.br.debian.org/debian/ http://ftp.us.debian.org/debian/

    Running netselect to choose 1 out of 4 addresses.       
    ..................................
    http://64.50.236.52/debian/            183 ms  16 hops  100% ok (10/10) [  475]
    http://208.80.154.139/debian/          191 ms  15 hops   25% ok ( 1/ 4) [ 1910]
    http://64.50.233.100/debian/           169 ms  15 hops   80% ok ( 8/10) [  527]
    http://ftp.br.debian.org/debian/       158 ms  16 hops  100% ok (10/10) [  410]
      410 http://ftp.br.debian.org/debian/


## netselect-apt
    $ sudo apt install netselect-apt

Automáticamente nos busca el repositorio más rápido entre la lista oficial de repositorios debian.

    $ sudo netselect-apt
