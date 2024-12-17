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

### rm-cambiarNombreHost.sh
```shell
tee rm-cambiarNombreHost.sh <<SHELL
#!/bin/bash
# Script para cambiar el nombre del host y reiniciar el sistema

clear

# Mostrar el nombre del host actual
H_ACTUAL=\$(hostname)
echo "Nombre del host actual: \$H_ACTUAL"

# Solicitar el nuevo nombre de host
read -p "Ingresa el nuevo nombre de host: " H_NUEVO

# Validar que se ingresó un nombre
if [ -z "\$H_NUEVO" ]; then
  echo "Error: No ingresaste un nombre de host válido."
  exit 1
fi

# Cambiar el nombre del host en los archivos de configuración y reiniciar
sudo sed -i "s/\$H_ACTUAL/\$H_NUEVO/g" /etc/hosts /etc/hostname && sudo reboot
SHELL

# Dar permisos de ejecución al script
chmod +x rm-cambiarNombreHost.sh
./rm-cambiarNombreHost.sh

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
