# Iniciar VMs o LXCs en Proxmox Basado en Paquetes WOL

![Estado: En Producción](https://img.shields.io/badge/Estado-En%20Producción-yellow)
![Versión: 0.2](https://img.shields.io/badge/Versión-0.2-yellow)
[![Autor: Lic. Ricardo MONLA](https://img.shields.io/badge/Autor-Lic.%20Ricardo%20MONLA-orange)](mailto:rmonla@gmail.com)

## Índice

1. [Descripción](#descripción)
2. [Procedimiento](#procedimiento)
3. [Referencias](#referencias)

## Descripción

Este script en Bash monitorea una interfaz de red en Proxmox para capturar paquetes Wake-on-LAN (WOL). Cuando se detecta un paquete WOL, el script extrae la dirección MAC y busca una VM o LXC con esa MAC en los archivos de configuración de Proxmox. Si la encuentra y está detenida, el script la inicia automáticamente, repitiendo este proceso cada 5 segundos.

## Procedimiento

1. **Inicia sesión en tu nodo de Proxmox y abre una terminal en "Shell".**

2. **Navega a tu directorio personal y crea una carpeta para scripts:**
   ```bash
   cd ~
   mkdir scripts
   cd scripts
   ```

3. **Crea un archivo de script llamado `wol_vm_proxmox.sh` y edítalo con `nano`:**
   ```bash
   nano wol_vm_proxmox.sh
   ```

4. **Pega el siguiente código en el archivo y guárdalo:**
   ```bash
   #!/bin/bash

   while true; do
     sleep 5
     
     wake_mac=$(tcpdump -c 1 -UlnXi vmbr1 ether proto 0x0842 or udp port 9 2>/dev/null |\
     sed -nE 's/^.*20:  (ffff|.... ....) (..)(..) (..)(..) (..)(..).*$/\2:\3:\4:\5:\6:\7/p')
     
     echo "Paquete mágico capturado para la dirección: \"${wake_mac}\""
     echo -n "Buscando una VM existente: "
     
     matches=($(grep -il ${wake_mac} /etc/pve/qemu-server/*))
     
     if [[ ${#matches[*]} -eq 0 ]]; then
       echo "${#matches[*]} encontrado"
       echo -n "Buscando un LXC existente: "
       matches=($(grep -il ${wake_mac} /etc/pve/lxc/*))
       
       if [[ ${#matches[*]} -eq 0 ]]; then
         echo "${#matches[*]} encontrado"
         continue
       elif [[ ${#matches[*]} -gt 1 ]]; then
         echo "${#matches[*]} encontrado, usando el primero encontrado"
       else
         echo "${#matches[*]} encontrado"
       fi
       
       vm_file=$(basename ${matches[0]})
       vm_id=${vm_file%.*}
       
       details=$(pct status ${vm_id} -verbose | egrep "^name|^status")
       name=$(echo ${details} | awk '{print $2}')
       status=$(echo ${details} | awk '{print $4}')
       
       if [[ "${status}" != "stopped" ]]; then
         echo "CONTENEDOR OMITIDO ${vm_id} : ${name} está ${status}"
       else
         echo "INICIANDO CONTENEDOR ${vm_id} : ${name} está ${status}"
         pct start ${vm_id}
       fi
       
       continue
     elif [[ ${#matches[*]} -gt 1 ]]; then
       echo "${#matches[*]} encontrado, usando el primero encontrado"
     else
       echo "${#matches[*]} encontrado"
     fi
     
     vm_file=$(basename ${matches[0]})
     vm_id=${vm_file%.*}
     
     details=$(qm status ${vm_id} -verbose | egrep "^name|^status")
     name=$(echo ${details} | awk '{print $2}')
     status=$(echo ${details} | awk '{print $4}')
     
     if [[ "${status}" != "stopped" ]]; then
       echo "VM OMITIDA ${vm_id} : ${name} está ${status}"
     else
       echo "INICIANDO VM ${vm_id} : ${name} está ${status}"
       qm start ${vm_id}
     fi
   done
   ```

5. **Guarda el archivo y dale permisos de ejecución:**
   ```bash
   chmod +x wol_vm_proxmox.sh
   ```

6. **Ejecuta el script para comenzar a monitorear los paquetes WOL y a iniciar automáticamente las VMs o LXCs correspondientes:**
   ```bash
   ./wol_vm_proxmox.sh
   ```

## Referencias

- [Proxmox Forum: Wake-on-LAN (WOL) for VMs and Containers](https://forum.proxmox.com/threads/wake-on-lan-wol-for-vms-and-containers.143879/)
