# How to install MariaDB on Ubuntu
![Estado: EnProceso](https://img.shields.io/badge/Estado-EnProceso-brightgreen)
![Versión: 0.2](https://img.shields.io/badge/Versión-0.2-blue)
[![Autor: Lic. Ricardo MONLA](https://img.shields.io/badge/Autor-Lic.%20Ricardo%20MONLA-orange)](mailto:rmonla@frlr.utn.edu.ar)

Fuente: [How to install MariaDB on Ubuntu](https://www.cherryservers.com/blog/how-to-install-and-start-using-mariadb-on-ubuntu-20-04)

# Instalación.

1. First, install the prerequisite package.
```bash
sudo apt install -y software-properties-common
```

2. Next, import the GPG signing key..
```bash
sudo apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc'
```

3. Once the GPG key is in place, add the MariaDB APT repository. The following repository is enabled for the MariaDB version 10.6. You may replace this value with the version that you intend to install.
```bash
sudo add-apt-repository 'deb [arch=amd64,arm64,ppc64el] https://mariadb.mirror.liquidtelecom.com/repo/10.6/ubuntu focal main'
```

4. Finally, refresh the local repositories and install the MariaDB server and client by using the APT package manager.
```bash
sudo apt update && sudo apt install -y mariadb-server mariadb-client
```
