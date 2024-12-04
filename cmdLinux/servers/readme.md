### rm-actuDistro.sh
```shell
clear && \
sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y && [ -f /var/run/reboot-required ] && sudo reboot -f
```

### rm-cambiarHostname.sh
```shell
clear && \
H_ACTUAL=$(hostname) && \
read -p "Ingresa el nuevo nombre de host: " H_NUEVO && \
sudo sed -i "s/$H_ACTUAL/$H_NUEVO/g" /etc/hosts /etc/hostname && \
sudo reboot
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
