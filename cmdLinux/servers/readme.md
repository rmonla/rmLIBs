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
