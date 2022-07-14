## [Live-USBs MultiBOOT](https://blog.desdelinux.net/como-crear-live-usbs-multiboot)
### 1.- Formateá el pendrive en una sola partición:

En un terminal escribí:
```
sudo su
fdisk -l
```
…y tomá nota de cuál es tu pendrive.
```
fdisk /dev/sdx
```
Recordá reemplazar la x con la letra de tu pendrive (ver paso anterior).
Luego…
```
d (para borrar la actual partición)
n (para crear una partición nueva)
p (para partición primaria)
1 (Crea la primera partición)
Enter (para usar el primer cilindro)
Enter de nuevo (para usar el valor por defecto para el último cilindro)
a (para activa)
1 (para marcar la primera partición como arrancable)
w (para escribir cambios y cerrar fdisk)
```

### 2.- Creá un sistema de archivos FAT32 en el pendrive:
```
umount /dev/sdx1 #(para desmontar la partición del pendrive)
mkfs.vfat -F 32 -n MULTIBOOT /dev/sdx1 #(para formatear la partición como fat32)
```
### 3.- Instalá Grub2 en el pendrive:
```
mkdir /media/MULTIBOOT #(crea el directorio para el punto de montaje)
mount /dev/sdx1 /media/MULTIBOOT #(monta el pendrive)
grub-install --force --no-floppy --root-directory=/media/MULTIBOOT /dev/sdx #(instala Grub2)
cd /media/MULTIBOOT/boot/grub #(cambias de directorio)
wget pendrivelinux.com/downloads/multibootlinux/grub.cfg #(descargas el fichero grub.cfg )
```
### 4.- Testeá que tu pendrive arranque con Grub2:

Reiniciá la computadora, y entrá en el BIOS. Configurá el orden de arranque para que inicie desde el USB – Boot from USB o similar. Salvá los cambios y reiniciá. Si todo va bien aparecerá un menú de GRUB.

### 5.- Añadiendo ISOs:
```
cd /media/MULTIBOOT #(si el Pendrive está aún montado allí)
```
Seguí las instrucciones para cada distro, cambiando el nombre de la ISO al que por defecto se usa en el grub.cfg que descargaste, por ejemplo, para xubuntu.iso renombrar a ubuntu.iso


## FFMPEG
### Unir varios archivos de video en uno.
```sh
vBusc='IEM_1ro_7Sep_2105'
(find . -type f -name $vBusc'*' -printf "file '$PWD/%p'\n" | sort) | ffmpeg -protocol_whitelist file,pipe -f concat -safe 0 -i pipe: -vcodec copy -acodec copy $vBusc'.mp4'
```

### Segmentar Video Desde un punto en adelante.
```sh
ffmpeg -i input.mp4 -ss 01:32:38 -c copy b-output1.mp4
```
    
### Segmentar Video Desde y Hasda.
```sh
ffmpeg -i 2021-06-25T01_02_05Z.mp4 -ss 00:17:55 -to 00:26:30 -c copy PSS_Pedro-1.mp4
```

### Segmentar Video en partes de 20 minutos.
```sh
ffmpeg -i source.mp4 -c copy -map 0 -segment_time 00:20:00 -f segment -reset_timestamps 1 output%03d.mp4
```
