# COPIA ENTRE SERVERS

## Copiar VM desde un server a otro por SSH --> [backup - Use SSHFS on XenServer 6.1 - Server Fault](https://serverfault.com/questions/493166/use-sshfs-on-xenserver-6-1)
NOTA: La VM debe estar en modo apagada o suspendida.
### Descargar imagen de una VM desde un server.
    ssh root@<XenServer_IP> "xe vm-export vm=<VM-UUID> filename=" > <ARCHIVO_DESTINO>.xva

### Copiar VM desde un server a otro.
    # xe vm-export uuid=<VM_UUID_ORIGEN_SRV_LOCAL> filename= | ssh root@<IP_SRV_DESTINO> 'xe vm-import filename=/dev/stdin sr-uuid=<UUID_DISCO_SRV_DESTINO>'
