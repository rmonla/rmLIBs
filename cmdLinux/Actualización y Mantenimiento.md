# Linux Actualización y Mantenimiento.
![Estado: EnProceso](https://img.shields.io/badge/Estado-EnProceso-brightgreen)
![Versión: 1.2](https://img.shields.io/badge/Versión-1.2-blue)
[![Autor: Lic. Ricardo MONLA](https://img.shields.io/badge/Autor-Lic.%20Ricardo%20MONLA-orange)](mailto:rmonla@frlr.utn.edu.ar)


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

## Ver la distribución instalada.
```
    cat /etc/*release
```
<p align="right"><img src="https://img.shields.io/badge/Linux-All-brightgreen" alt="Linux: All"></p>

## *Cambiar el nombre del host.*
```bash
clear && H_ACTUAL=$(hostname) && read -p "Ingresa el nuevo nombre de host: " H_NUEVO && sudo sed -i "s/$H_ACTUAL/$H_NUEVO/g" /etc/hosts /etc/hostname && sudo reboot
```
- Este comando cambia el nombre de host del sistema y luego reinicia para que los cambios surtan efecto.
<p align="right"><img src="https://img.shields.io/badge/Linux-All-brightgreen" alt="Linux: All"></p>
