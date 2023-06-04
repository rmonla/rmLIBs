# Cómo instalar Serviio en Debian 11 "bullseye"
Fuente: [How to install serviio dlna server on linux debian with ffmpeg and default-jre java howto](https://www.youtube.com/watch?v=99XzSTYO_Mw)


Serviio es un servidor de medios de comunicación gratuito que permite transmitir contenido multimedia (como videos, música y fotos) a dispositivos compatibles con DLNA (Digital Living Network Alliance), como televisores inteligentes, consolas de videojuegos y reproductores de medios. Facilita la transmisión de archivos multimedia desde una computadora a otros dispositivos en la red local.

1. Actualizar el nombre del host.

```bash
antiguo_nombre=$(hostname) && read -p "Ingresa el nuevo nombre de host: " nuevo_nombre \
&& sudo sed -i "s/$antiguo_nombre/$nuevo_nombre/g" /etc/hosts \
&& sudo hostnamectl set-hostname "$nuevo_nombre" \
&& sudo reboot 
```

2. Actualizar el sistema.

```bash
sudo apt update -y \
&& sudo apt full-upgrade -y \
&& [ -f /var/run/reboot-required ] \
&& sudo reboot
```

3. Instalar complementos.

```bash
sudo apt install ffmpeg default-jre screen -y
```

4. Crear el usuario serviio.

```bash
sudo adduser serviio
```

5. Conectarse por SSH con el usuario serviio.

```bash
ssh serviio@IP_SERVIIO -> PASS_serviio
```

6. Descargar y descomprimir Serviio.

```bash
wget https://download.serviio.org/releases/serviio-2.3-linux.tar.gz \
&& tar zxvf serviio-2.3-linux.tar.gz
```

7. Ingresar y ejecutar.

```bash
screen /home/serviio/serviio-2.3/bin/serviio.sh -> 'Ctrl + A' seguido de la tecla 'd' para salir
```

8. Acceder por web.

```
http://IP_SERVIIO:23423/console/
```

9. Comandos combinados.

```bash
antiguo_nombre=$(hostname) && read -p "Ingresa el nuevo nombre de host: " nuevo_nombre \
&& sudo sed -i "s/$antiguo_nombre/$nuevo_nombre/g" /etc/hosts \
&& sudo hostnamectl set-hostname "$nuevo_nombre" \
&& sudo reboot 

sudo apt update -y \
&& sudo apt full-upgrade -y \
&& [ -f /var/run/reboot-required ] \
&& sudo reboot

sudo apt install ffmpeg default-jre screen -y \
&& sudo adduser serviio 

ssh serviio@IP_SERVIIO -> PASS_serviio

wget https://download.serviio.org/releases/serviio-2.3-linux.tar.gz \
&& tar zxvf serviio-2.3-linux.tar.gz \
&& screen /home/serviio/serviio-2.3/bin/serviio.sh -> 'Ctrl + A' seguido de la tecla 'd' para salir \
&& echo "Accede a: http://IP_SERVIIO:23423/console/"
```

# Sería necesario consultar [Linux Daemon scripts](https://forum.serviio.org/viewtopic.php?f=4&t=71) para configurarlo como un servicio.
