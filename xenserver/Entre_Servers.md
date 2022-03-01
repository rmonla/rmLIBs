# rmLIBs - XenServer

## Copiar VM desde un server a otro por SSH --> [backup - Use SSHFS on XenServer 6.1 - Server Fault](https://serverfault.com/questions/493166/use-sshfs-on-xenserver-6-1)
NOTA: La VM debe estar en modo apagada o suspendida.
### Descargar imagen de una VM desde un server.
    ssh root@<XenServer_IP> "vm-export uuid=the-vm-uuid filename=" > <ARCHIVO_DESTINO>.xva

### Copiar VM desde un server a otro.
    xe vm-export uuid=<VM_UUID> filename= | ssh root@<XS7_IP> 'xe vm-import filename=/dev/stdin sr-uuid=<XS7_LOCAL_STORAGE_UUID>'
