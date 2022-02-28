## rmLIBs - XenServer
### [Almacenamiento en Citrix XenServer: cómo funciona y qué puede fallar](https://www.computerweekly.com/es/consejo/Almacenamiento-en-Citrix-XenServer-como-funciona-y-que-puede-fallar)
    xe sr-list
        Este comando muestra los UUID actualmente en uso junto a los demás parámetros que nos permiten identificar el tipo de almacenamiento.
    xe sr-rescan
        Para escanear de nuevo los identificadores de los dispositivos físicos y volver a construir la base de datos.

### [¿Cómo añadir un disco nuevo a XenServer y crear el SR local?](https://www.josemariagonzalez.es/citrix/como-anadir-disco-nuevo-xenserver-crear-sr-local.html)
#### 1.- Localizamos el ID del disco:
    ll /dev/disk/by-id

#### 2.- Una vez Localizado el id, creamos el SR Local:
    xe sr-create content-type=user device-config:device=/dev/disk/by-id/ host-uuid= name-label=”Disco Local 2” shared=false type=lvm 
