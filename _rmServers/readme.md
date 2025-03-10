<!--  
# Ricardo Monla (https://github.com/rmonla)
# _rmServers - v250305-2025
-->



### rm-actuDistro.sh
```shell
tee rm-actuDistro.sh <<SHELL
#!/bin/bash
# Script para actualizar y reiniciar si es necesario

# Versión: 241213-1622

clear
sudo apt update -y && \
sudo apt full-upgrade -y && \
sudo apt autoremove -y && \
if [ -f /var/run/reboot-required ]; then
    read -p "El sistema requiere un reinicio. ¿Deseas reiniciar ahora? (s/n): " RESPUESTA
    if [[ "$RESPUESTA" =~ ^[sS](i|I)?$ ]]; then
        sudo reboot -f
    else
        echo "No se reinició el sistema. Por favor, recuerda reiniciar más tarde."
    fi
else
    echo "No se requiere reinicio."
fi
SHELL

# Dar permisos de ejecución al script
chmod +x rm-actuDistro.sh

# Ejecutar el script
./rm-actuDistro.sh
```



### Debian-actualizarIP
```shell
sudo nano /etc/network/interfaces
```

```shell
# Fuente de otros archivos de configuración de interfaces
source /etc/network/interfaces.d/*

# La interfaz de loopback (siempre debe estar configurada así)
auto lo
iface lo inet loopback

# Permitir que la interfaz se active automáticamente cuando se detecte
allow-hotplug ens18

# Configuración de la IP dinámica
# iface ens18 inet dhcp

# Configuración de la IP estática
iface ens18 inet static
    address 192.168.1.100
    netmask 255.255.255.0
    gateway 192.168.1.1
    dns-nameservers 8.8.8.8 8.8.4.4

```
