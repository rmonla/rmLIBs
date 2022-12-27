# COPIA ENTRE SERVERS

## Copiar VM desde un server a otro por SSH --> [backup - Use SSHFS on XenServer 6.1 - Server Fault](https://serverfault.com/questions/493166/use-sshfs-on-xenserver-6-1)
NOTA: La VM debe estar en modo apagada o suspendida.
### Descargar imagen de una VM desde un server.
    DST_NOM='SRV_VNS06_SysACAD-Web_WS2008' \
    UUID_VM='2f49e4bf-2c44-2676-4a31-a74773fe3ae5' \
    IP_XenS='10.0.10.24' \
    DST_DIR='/home/rmonla/Documentos/BakupXenCenter/' \

    ssh root@$IP_XenS "xe vm-export vm=$UUID_VM filename=" > $DST_DIR$DST_NOM.xva

### Copiar VM desde un server a otro.
    # xe vm-export uuid=<VM_UUID_ORIGEN_SRV_LOCAL> filename= | ssh root@<IP_SRV_DESTINO> 'xe vm-import filename=/dev/stdin sr-uuid=<UUID_DISCO_SRV_DESTINO>'
