# Cómo instalar KasperskySecurityCenter en Ubuntu 20
![Estado: EnProceso](https://img.shields.io/badge/Estado-EnProceso-brightgreen)
![Versión: 0.2](https://img.shields.io/badge/Versión-0.2-blue)
[![Autor: Lic. Ricardo MONLA](https://img.shields.io/badge/Autor-Lic.%20Ricardo%20MONLA-orange)](mailto:rmonla@frlr.utn.edu.ar)

Fuente: [Instalación de Kaspersky Security Center Linux ](https://support.kaspersky.com/ksclinux/14.2/es-MX/166764.htm)

Kaspersky Security Center es una plataforma de gestión de seguridad desarrollada por Kaspersky Lab, una empresa líder en ciberseguridad. Esta plataforma proporciona herramientas integrales para administrar la seguridad de los sistemas informáticos en redes empresariales y corporativas.

Algunas de las funciones principales de Kaspersky Security Center incluyen:

1. Gestión centralizada de la seguridad: Permite administrar de manera centralizada las políticas de seguridad, las actualizaciones de software, la monitorización de amenazas y otras funciones relacionadas con la seguridad de los sistemas informáticos en toda la red.

2. Implementación y mantenimiento de antivirus: Facilita la instalación, configuración y actualización de soluciones antivirus y antimalware en todos los dispositivos de la red, lo que ayuda a proteger contra virus, malware y otras amenazas cibernéticas.

3. Control de dispositivos: Permite gestionar y controlar el acceso a dispositivos externos, como unidades USB, discos duros externos y otros dispositivos de almacenamiento, con el fin de prevenir la pérdida de datos y proteger contra amenazas potenciales.

4. Monitorización y generación de informes: Proporciona capacidades de monitorización en tiempo real y generación de informes detallados sobre la seguridad de la red, incluyendo actividades sospechosas, eventos de seguridad y tendencias de amenazas.

En resumen, Kaspersky Security Center es una herramienta integral que ayuda a las organizaciones a gestionar y mantener la seguridad de sus sistemas informáticos de manera eficiente y centralizada.

# Instalación.
1. Actualizar el nombre del host.

```bash
clear && antiguo_nombre=$(hostname) && read -p "Ingresa el nuevo nombre de host: " nuevo_nombre && \
sudo sed -i "s/$antiguo_nombre/$nuevo_nombre/g" /etc/hosts /etc/hostname && \
sudo reboot
```

2. Actualizar el sistema.

```bash
clear && sudo apt update -y && sudo apt full-upgrade -y && \
[ -f /var/run/reboot-required ] && sudo reboot
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
read -p "Ingresa la IP del servidor Serviio: " IP_SERVIIO && \
ssh serviio@$IP_SERVIIO -> PASS_serviio
```

6. Descargar y descomprimir Serviio.

```bash
wget https://download.serviio.org/releases/serviio-2.3-linux.tar.gz && \
tar zxvf serviio-2.3-linux.tar.gz
```

8. Cargar pildora.

```bash
screen -dmS serviio_run /home/serviio/serviio-2.3/bin/serviio.sh
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
clear && antiguo_nombre=$(hostname) && read -p "Ingresa el nuevo nombre de host: " nuevo_nombre && \
sudo sed -i "s/$antiguo_nombre/$nuevo_nombre/g" /etc/hosts /etc/hostname && \
sudo reboot

clear && sudo apt update -y && sudo apt full-upgrade -y && \
[ -f /var/run/reboot-required ] && sudo reboot

sudo apt install ffmpeg default-jre screen -y && \
sudo adduser serviio && exit 

read -p "Ingresa la IP del servidor Serviio: " IP_SERVIIO && \
ssh serviio@$IP_SERVIIO

wget https://download.serviio.org/releases/serviio-2.3-linux.tar.gz && \
tar zxvf serviio-2.3-linux.tar.gz && \
screen -dmS serviio_run /home/serviio/serviio-2.3/bin/serviio.sh && \
echo "Accede a: http://$IP_SERVIIO:23423/console/"
```

# Sería necesario consultar [Linux Daemon scripts](https://forum.serviio.org/viewtopic.php?f=4&t=71) para configurarlo como un servicio.
