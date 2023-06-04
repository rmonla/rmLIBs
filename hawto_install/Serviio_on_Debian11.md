# Cómo instalar Serviio en Debian 11 "bullseye"
Fuente: [How to install serviio dlna server on linux debian with ffmpeg and default-jre java howto](https://www.youtube.com/watch?v=99XzSTYO_Mw)


Serviio es un servidor de medios de comunicación gratuito que permite transmitir contenido multimedia (como videos, música y fotos) a dispositivos compatibles con DLNA (Digital Living Network Alliance), como televisores inteligentes, consolas de videojuegos y reproductores de medios. Facilita la transmisión de archivos multimedia desde una computadora a otros dispositivos en la red local.

1. Actualizar el nombre del host.

```bash
clear && antiguo_nombre=$(hostname) && read -p "Ingresa el nuevo nombre de host: " nuevo_nombre \
&& sudo sed -i "s/$antiguo_nombre/$nuevo_nombre/g" /etc/hosts /etc/hostname \
&& sudo reboot
```

2. Actualizar el sistema.

```bash
clear && sudo apt update -y && sudo apt full-upgrade -y \
&& [ -f /var/run/reboot-required ] && sudo reboot
```

3. Instalar complementos.

```bash
sudo apt install ffmpeg default-jre screen -y
```

4. Crear el usuario serviio.

```bash
sudo adduser serviio && exit 
```

5. Conectarse por SSH con el usuario serviio.

```bash
read -p "Ingresa la IP del servidor Serviio: " IP_SERVIIO \
&& ssh serviio@$IP_SERVIIO -> PASS_serviio
```

6. Descargar y descomprimir Serviio.

```bash
wget https://download.serviio.org/releases/serviio-2.3-linux.tar.gz \
&& tar zxvf serviio-2.3-linux.tar.gz
```

7. Ejecutar Serviio en segundo plano.

```bash
screen -dmS serviio_run /home/serviio/serviio-2.3/bin/serviio.sh
```

8. Acceder por web.

```
http://IP_SERVIIO:23423/console/
```

# Comandos combinados.

```bash
clear && antiguo_nombre=$(hostname) && read -p "Ingresa el nuevo nombre de host: " nuevo_nombre \
&& sudo sed -i "s/$antiguo_nombre/$nuevo_nombre/g" /etc/hosts /etc/hostname \
&& sudo reboot

clear && sudo apt update -y && sudo apt full-upgrade -y \
&& [ -f /var/run/reboot-required ] && sudo reboot

sudo apt install ffmpeg default-jre screen -y \
&& sudo adduser serviio && exit 

read -p "Ingresa la IP del servidor Serviio: " IP_SERVIIO \
&& ssh serviio@$IP_SERVIIO

wget https://download.serviio.org/releases/serviio-2.3-linux.tar.gz \
&& tar zxvf serviio-2.3-linux.tar.gz \
&& screen -dmS serviio_run /home/serviio/serviio-2.3/bin/serviio.sh \
&& echo "Accede a: http://$IP_SERVIIO:23423/console/"
```

# Sería necesario consultar [Linux Daemon scripts](https://forum.serviio.org/viewtopic.php?f=4&t=71) para configurarlo como un servicio.
