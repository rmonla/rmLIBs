# ALMACENAMIENTO
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

# BACKUPs

## Backup de la BD de configuración del Pool [El servidor Master en XenServer](https://www.josemariagonzalez.es/citrix/el-servidor-master-en-xenserver.html)
### Archivo de la BD:
    /var/xapi/state.db
### Respaldar BD.
    xe pool-dump-database file-name=<path and filename>
### Restaurar Backup de BD.
    xe pool-restore-database file-name=<path to backup file>

Con esto vamos a tener que reiniciar y la base de datos volverá a estar operativa, con toda la configuración de Storage, máquinas virtuales, redes, etc….

# COPIA ENTRE SERVERS

## Copiar VM desde un server a otro por SSH --> [backup - Use SSHFS on XenServer 6.1 - Server Fault](https://serverfault.com/questions/493166/use-sshfs-on-xenserver-6-1)
NOTA: La VM debe estar en modo apagada o suspendida.
### Descargar imagen de una VM desde un server.
    ssh root@<XenServer_IP> "xe vm-export vm=<VM-UUID> filename=" > <ARCHIVO_DESTINO>.xva

### Copiar VM desde un server a otro.
    xe vm-export uuid=<VM_UUID> filename= | ssh root@<XS7_IP> 'xe vm-import filename=/dev/stdin sr-uuid=<XS7_LOCAL_STORAGE_UUID>'

# XENCENTER

## [How to download the XenServer XenCenter client](https://electrictoolbox.com/download-xencenter-client/)
### ...if your server’s IP address is 10.1.1.1, the link will be to:
    http://10.1.1.1/

# INICIO PROGRAMADO

## [Inicio automático de máquinas virtuales con XenServer](https://pornohardware.com/2014/12/24/inicio-automatico-de-maquinas-virtuales-con-xenserver/)

### 1 Crear una vApp. 
    Ver Enlace.
### 2 Identificador (UUID) de vApp. 
    $ sudo xe appliance-list
### 3 Editar el archivo /etc/rc.local
# Start the main vApp to boot the VMs
    xe appliance-start uuid=6373fb13-520b-aafb-eae3-ea0cb47ca64a

