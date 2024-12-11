![Estado: Estable](https://img.shields.io/badge/Estado-Estable-brightgreen)
![Versión: 2.5](https://img.shields.io/badge/Versión-2.5-blue)
[![Autor: Lic. Ricardo MONLA](https://img.shields.io/badge/Autor-Lic.%20Ricardo%20MONLA-orange)](mailto:rmonla@frlr.utn.edu.ar)
--------------  

# COPIA ENTRE SERVERS

## Copiar VM desde un server a otro por SSH 
Fuente: [backup - Use SSHFS on XenServer 6.1 - Server Fault](https://serverfault.com/questions/493166/use-sshfs-on-xenserver-6-1)

NOTA: La VM debe estar en modo apagada o suspendida.

### Parado En el Servidor.

```bash
VM_NOM="srv-Sitio1"
VM_UUID="6d54b7f3-107e-5b7e-d77d-8c4c5ef9ebc0"
DESTINO="/media/rmonla/ticFiles/ticBKPs/Servers/${VM_NOM}_$(date +'%y%m%d-%H%M').xva"

xe vm-export uuid=$VM_UUID filename= | ssh rmonla@10.0.10.17 -p 7022 "cat > $DESTINO"
```

### Parado Fuera del Servidor.

```bash
VM_NOM="srv-VN10-SiGesDocs"
VM_UUID="968e2436-f9f1-4955-32ee-3dd30714d8e7"
SRV_C0N="root@10.0.10.24"

ARCH_NOM="${VM_NOM}_$(date +'%y%m%d-%H%M').xva"
ARCH_TMP="/home/rmonla/Downloads/${ARCH_NOM}"
ARCH_COMP="/media/rmonla/ticFiles/ticBKPs/Servers/${ARCH_NOM}.tar.gz"

clear
echo "Descargando máquina virtual [${VM_NOM}] desde el server..."
ssh $SRV_C0N "xe vm-export vm=${VM_UUID} filename= " > $ARCH_TMP
echo "Comprimiendo archivo temporal [${ARCH_NOM}]..."
tar cf - $ARCH_TMP | pv -s $(du -sb $ARCH_TMP | awk '{print $1}') | gzip > $ARCH_COMP
rm $ARCH_TMP
echo "Descarga, Compresión y limpieza de temporales realizado."
echo ""
```
### Iterando En el Servidor.
```bash
#!/bin/bash

# Array de VMs con sus UUIDs
vms=(
    ["x_srv-Proxy2"]="f5ad589c-84bd-9882-fbc8-76439e937332"
    ["srv-MauriK"]="21c5567b-c4c5-14b5-c70c-9b4e8b506c4c"
    ["srv-Sitio1"]="6d54b7f3-107e-5b7e-d77d-8c4c5ef9ebc0"
)

# Iterar sobre el array
for vm_nom in "${!vms[@]}"; do
    vm_uuid="${vms[$vm_nom]}"
    
    # Construir el destino
    destino="/media/rmonla/ticFiles/ticBKPs/Servers/${vm_nom}_$(date +'%y%m%d-%H%M').xva"
    
    # Exportar la VM y copiar a destino
    xe vm-export uuid="$vm_uuid" filename= | ssh rmonla@10.0.10.17 -p 7022 "cat > $destino"
    
    echo "Iteración completada para VM: $vm_nom"
done
```

### Descargar imagen de una VM desde un server.


```bash
clear && \
DST_NOM="srv-MauriK_$(date +'%y%m%d-%H%M')" && \
UUID_VM="21c5567b-c4c5-14b5-c70c-9b4e8b506c4c" && \
IP_XenS="10.0.10.23" && \
DST_DIR="/media/rmonla/ticFiles/ticBKPs/Servers/" && \
ssh root@$IP_XenS "xe vm-export vm=$UUID_VM filename=" > $DST_DIR$DST_NOM.xva
```

### Copiar VM desde un server a otro.

- Desde Xen2 a Xen1

```bash
clear && \
ID_VM_ORI='0673387f-7370-00f0-afb9-57be1c4bae3f' && \
IP_SRV_DST='10.0.10.23' && \
ID_DISCO_DST='7be246e2-fd58-24d3-e8d4-26084f9fb2df' && \
xe vm-export uuid="$ID_VM_ORI" filename= | ssh root@"$IP_SRV_DST" "xe vm-import filename=/dev/stdin sr-uuid=$ID_DISCO_DST"
```
