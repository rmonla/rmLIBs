# Cómo instalar Serviio en Debian 11 "bullseye"
Fuente: [Serviio The latest release](https://serviio.org/download)

Kodi es un gestor de contenidos multimediales que te permite organizar y reproducir una variedad de formatos de medios, como películas, música y fotos, en diferentes dispositivos. Proporciona una interfaz intuitiva y personalizable que facilita la navegación y la reproducción de tus archivos multimedia. Con Kodi, puedes disfrutar de tu biblioteca de medios en tu televisor, computadora, teléfono inteligente o tableta de manera fácil y conveniente.

1. Actualización del sistema

```bash
sudo apt update -y && sudo apt full-upgrade -y && [ -f /var/run/reboot-required ] && sudo reboot -f
```
1. Actualizo Hostname

```bash
sudo hostnamectl set-hostname "$(read -p 'Nuevo nombre de host: ' nuevo_nombre && echo $nuevo_nombre)" && sudo reboot
```
3. Instalar FFmpeg

```bash
sudo apt install ffmpeg rtmpdump lame dcraw -y
```
4. Para instalar los complementos binarios de Kodi, PVR IPTV Simple

```bash
sudo apt install kodi-pvr-mythtv -y
```


99. En un solo comando.
```bash


```
