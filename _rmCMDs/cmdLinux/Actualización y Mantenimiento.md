# Linux Actualización y Mantenimiento.
![Estado: EnProceso](https://img.shields.io/badge/Estado-EnProceso-brightgreen)
![Versión: 1.2](https://img.shields.io/badge/Versión-1.2-blue)
[![Autor: Lic. Ricardo MONLA](https://img.shields.io/badge/Autor-Lic.%20Ricardo%20MONLA-orange)](mailto:rmonla@frlr.utn.edu.ar)



## Ver la distribución instalada.
```bash
lsb_release -a

No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 24.04.1 LTS
Release:        24.04
Codename:       noble
```
<p align="right"><img src="https://img.shields.io/badge/Linux-All-brightgreen" alt="Linux: All"></p>

```bash
cat /etc/*release

DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=24.04
DISTRIB_CODENAME=noble
DISTRIB_DESCRIPTION="Ubuntu 24.04.1 LTS"
PRETTY_NAME="Ubuntu 24.04.1 LTS"
NAME="Ubuntu"
VERSION_ID="24.04"
VERSION="24.04.1 LTS (Noble Numbat)"
VERSION_CODENAME=noble
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=noble
LOGO=ubuntu-logo

```
<p align="right"><img src="https://img.shields.io/badge/Linux-All-brightgreen" alt="Linux: All"></p>

```bash
inxi -Sxxx

System:    Host: srv-ns7 Kernel: 4.19.0-27-amd64 x86_64 bits: 64 compiler: gcc v: 8.3.0 
           Console: tty 0 dm: LightDM 1.26.0 Distro: Debian GNU/Linux 10 (buster) 
```
<p align="right"><img src="https://img.shields.io/badge/Linux-All-brightgreen" alt="Linux: All"></p>

```bash
uname -r

4.19.0-27-amd64
```

<p align="right"><img src="https://img.shields.io/badge/Linux-All-brightgreen" alt="Linux: All"></p>

## *Actualizar del sistema.*

```bash
sudo apt update -y && sudo apt full-upgrade  -y && [ -f /var/run/reboot-required ] && sudo reboot -f
```
- Este comando actualiza tu sistema, instala todas las mejoras disponibles y, si es necesario, reinicia automáticamente la computadora para aplicar los cambios.
<p align="right"><img src="https://img.shields.io/badge/Linux-All-brightgreen" alt="Linux: All"></p>

## *Actualizar a la última versión de Ubuntu.*
```bash
  do-release-upgrade
```
- *do-release-upgrade* es un comando diseñado específicamente para actualizar sistemas Ubuntu a la última versión disponible. .
<p align="right"><img src="https://img.shields.io/badge/Linux-Ubuntu-orange" alt="Linux: Ubuntu"></p>

## *Cambiar el nombre del host.*
```bash
clear && H_ACTUAL=$(hostname) && read -p "Ingresa el nuevo nombre de host: " H_NUEVO && sudo sed -i "s/$H_ACTUAL/$H_NUEVO/g" /etc/hosts /etc/hostname && sudo reboot
```
- Este comando cambia el nombre de host del sistema y luego reinicia para que los cambios surtan efecto.
<p align="right"><img src="https://img.shields.io/badge/Linux-All-brightgreen" alt="Linux: All"></p>
