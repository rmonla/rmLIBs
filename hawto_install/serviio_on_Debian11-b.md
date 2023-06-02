# Cómo instalar Serviio en Debian 11 "bullseye"
Fuente: [How to install serviio dlna server on linux debian with ffmpeg and default-jre java howto](https://www.youtube.com/watch?v=99XzSTYO_Mw)

Serviio es un ....

1. Actualización del sistema

```bash
sudo apt update -y && sudo apt full-upgrade -y && [ -f /var/run/reboot-required ] && sudo reboot -f
```
1. Actualizo Hostname

```bash
sudo hostnamectl set-hostname "$(read -p 'Nuevo nombre de host: ' nuevo_nombre && echo $nuevo_nombre)" && sudo reboot
```
3. Instalar complementos

```bash
sudo apt install ffmpeg default-jre screen -y
```
4. Crear usuario serviio

```bash
sudo adduser serviio
```
5. Conectarse por ssh con el usuario serviio

```bash
su serviio
```
4. Descargar el serviio 

```bash
wget https://download.serviio.org/releases/serviio-2.3-linux.tar.gz
```
4. Descomprimir el archivo. 

```bash
tar zxvf serviio-2.3-linux.tar.gz
```
4. Ingresar y Ejectur. 

```bash
ssh serviio@IP_SERVIIO -> PASS_serviio
screen /home/serviio/serviio-2.3/bin/serviio.sh -> 'Ctrl + A' seguida de la tecla 'd' para salir
```
4. Acceder por web. 

```bash
http://10.0.10.135:23423/console/
```


99. En un solo comando.
```bash


```



# Faltaria ver [Linux Daemon scripts](https://forum.serviio.org/viewtopic.php?f=4&t=71) para configurarlo como servicio