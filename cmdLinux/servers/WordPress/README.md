# WordPress en Ubuntu.
![Estado: EnProceso](https://img.shields.io/badge/Estado-EnProceso-brightgreen)
![Versión: 0.1](https://img.shields.io/badge/Versión-0.1-blue)
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
