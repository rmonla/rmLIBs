![Estado: Estable](https://img.shields.io/badge/Estado-Estable-brightgreen)
![Versión: 2.2](https://img.shields.io/badge/Versión-2.2-blue)
[![Autor: Lic. Ricardo MONLA](https://img.shields.io/badge/Autor-Lic.%20Ricardo%20MONLA-orange)](mailto:rmonla@frlr.utn.edu.ar)
--------------  

# COPIA ENTRE SERVERS

## Copiar VM desde un server a otro por SSH 
Fuente: [backup - Use SSHFS on XenServer 6.1 - Server Fault](https://serverfault.com/questions/493166/use-sshfs-on-xenserver-6-1)

NOTA: La VM debe estar en modo apagada o suspendida.

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
