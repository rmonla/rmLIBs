# Como Instalar MariaDB en Ubuntu.
![Estado: EnProceso](https://img.shields.io/badge/Estado-EnProceso-brightgreen)
![Versión: 1.2](https://img.shields.io/badge/Versión-1.2-blue)
[![Autor: Lic. Ricardo MONLA](https://img.shields.io/badge/Autor-Lic.%20Ricardo%20MONLA-orange)](mailto:rmonla@frlr.utn.edu.ar)

Fuente: 
- [How to install MariaDB on Ubuntu](https://www.cherryservers.com/blog/how-to-install-and-start-using-mariadb-on-ubuntu-20-04)
 
- [How to Install and Start Using MariaDB on Ubuntu 20.04 | Step-by-Step](https://www.cherryservers.com/blog/how-to-install-and-start-using-mariadb-on-ubuntu-20-04)


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

