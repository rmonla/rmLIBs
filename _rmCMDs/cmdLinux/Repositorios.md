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


# Config ATP de Forma Manual
## BRAVE
    
    sudo apt install apt-transport-https curl

    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

    sudo apt update

    sudo apt install brave-browser

## WebMin
Using the Webmin APT repository
If you like to install and update Webmin via APT, edit the /etc/apt/sources.list file on your system and add the line :
    
    deb https://download.webmin.com/download/repository sarge contrib

If that file does not exist, instead create /etc/apt/sources.list.d/webmin.list containing :
    
    deb [signed-by=/usr/share/keyrings/jcameron-key.gpg] https://download.webmin.com/download/repository sarge contrib

You should also fetch and install my GPG key with which the repository is signed, with the commands :
cd /root

    wget https://download.webmin.com/jcameron-key.asc
    apt-key add jcameron-key.asc

On Debian 11 and Ubuntu 22.04 or higher, the commands are :

    cd /root
    wget https://download.webmin.com/jcameron-key.asc
    cat jcameron-key.asc | gpg --dearmor >/usr/share/keyrings/jcameron-key.gpg

You will now be able to install with the commands :

    apt-get install apt-transport-https
    apt-get update
    apt-get install webmin

All dependencies should be resolved automatically.
