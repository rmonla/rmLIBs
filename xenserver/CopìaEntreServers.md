# COPIA ENTRE SERVERS

## Copiar VM desde un server a otro por SSH --> [backup - Use SSHFS on XenServer 6.1 - Server Fault](https://serverfault.com/questions/493166/use-sshfs-on-xenserver-6-1)
NOTA: La VM debe estar en modo apagada o suspendida.
### Descargar imagen de una VM desde un server.
    IP_XenS='10.0.10.23' \
    UUID_VM='adb8046c-f414-bde9-e7b7-6ae824c08933' \
    DST_NOM='SRV_V_PROXY-2-Intranet_Deb8_221129-1523' \

    ssh root@$IP_Xen1 "xe vm-export vm=$UUID_VM filename=" > $DST_NOM.xva

### Copiar VM desde un server a otro.
    # xe vm-export uuid=<VM_UUID_ORIGEN_SRV_LOCAL> filename= | ssh root@<IP_SRV_DESTINO> 'xe vm-import filename=/dev/stdin sr-uuid=<UUID_DISCO_SRV_DESTINO>'
