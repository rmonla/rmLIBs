# rmLIBs - XenServer
## [Almacenamiento en Citrix XenServer: cómo funciona y qué puede fallar](https://www.computerweekly.com/es/consejo/Almacenamiento-en-Citrix-XenServer-como-funciona-y-que-puede-fallar)
    xe sr-list
        Este comando muestra los UUID actualmente en uso junto a los demás parámetros que nos permiten identificar el tipo de almacenamiento.
    xe sr-rescan
        Para escanear de nuevo los identificadores de los dispositivos físicos y volver a construir la base de datos.

## [¿Cómo añadir un disco nuevo a XenServer y crear el SR local?](https://www.josemariagonzalez.es/citrix/como-anadir-disco-nuevo-xenserver-crear-sr-local.html)
### 1.- Localizamos el ID del disco:
    ll /dev/disk/by-id
### 2.- Una vez Localizado el id, creamos el SR Local:
    xe sr-create content-type=user device-config:device=/dev/disk/by-id/ host-uuid= name-label=”Disco Local 2” shared=false type=lvm 

## [How to download the XenServer XenCenter client](https://electrictoolbox.com/download-xencenter-client/)
### ...if your server’s IP address is 10.1.1.1, the link will be to:
    http://10.1.1.1/

## [How to add ISO image storage repository on XenServer Linux](https://linuxconfig.org/how-to-add-iso-image-storage-repository-on-xenserver-7-linux)
### Crear directorio almacen
#### Crear Directorio
    # mkdir /var/opt/ISO_IMAGES
#### Copiar o descargar ISO
    # cd /var/opt/ISO_IMAGES
    # wget http://debian.uberglobalmirror.com/debian-cd/8.5.0/amd64/iso-cd/debian-8.5.0-amd64-CD-1.iso

### Crear repositorio de almacenamiento
#### Crear/Registrar el nuevo repositorio de almacenamiento en XenServer:
    # xe sr-create name-label=ISO_IMAGES_LOCAL type=iso device-config:location=/var/opt/ISO_IMAGES device-config:legacy_mode=true content-type=iso
