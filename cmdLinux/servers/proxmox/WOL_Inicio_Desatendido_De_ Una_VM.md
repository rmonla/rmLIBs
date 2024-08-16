
# Script para Iniciar VMs o LXCs en Proxmox Basado en Paquetes WOL

![Estado: Completado](https://img.shields.io/badge/Estado-Completado-green)
![Versión: 1.0](https://img.shields.io/badge/Versión-1.0-blue)
[![Autor: Lic. Ricardo MONLA](https://img.shields.io/badge/Autor-Lic.%20Ricardo%20MONLA-orange)](mailto:rmonla@gmail.com)

## Índice

1. [Descripción](#descripción)
2. [Procedimiento](#procedimiento)
3. [Referencias](#referencias)

## Descripción

Este script en Bash está diseñado para monitorear una interfaz de red en Proxmox y capturar paquetes Wake-on-LAN (WOL). Cuando se detecta un paquete WOL, el script extrae la dirección MAC del paquete y busca en los archivos de configuración de Proxmox una VM o LXC que coincida con esa MAC. Si encuentra una coincidencia y la máquina o contenedor está detenido, el script lo inicia automáticamente. Este proceso se repite cada 5 segundos, lo que permite gestionar automáticamente el encendido de máquinas virtuales o contenedores en respuesta a solicitudes WOL.

## Procedimiento

1. Inicia sesión en tu nodo de Proxmox y abre una terminal en "Shell".
2. Navega a tu directorio personal y crea una carpeta para scripts:
   ```bash
   cd ~
   mkdir scripts
   cd scripts
   ```
3. Crea un archivo de script llamado `wol_hack.sh` y edítalo con `nano`:
   ```bash
   nano wol_hack.sh
   ```
4. Pega el siguiente código en el archivo y guárdalo:
   ```bash
   #!/bin/bash

   # Intenta iniciar una VM o LXC de Proxmox que coincida con la dirección MAC recibida en un mensaje WOL.
   # Esto podría ser peligroso si se abusa, saturando la interfaz con muchos paquetes,
   # así que se intenta solo una vez cada 5 segundos.
   # En mi caso, es útil con el cliente Moonlight.
   # Usa tcpdump en la interfaz predeterminada de Proxmox, cambia la interfaz si es necesario.

   while true; do
     # Pausa de 5 segundos entre cada intento.
     sleep 5
     
     # Captura un paquete mágico de WOL y extrae la dirección MAC.
     wake_mac=$(tcpdump -c 1 -UlnXi vmbr1 ether proto 0x0842 or udp port 9 2>/dev/null |\
     sed -nE 's/^.*20:  (ffff|.... ....) (..)(..) (..)(..) (..)(..).*$/\2:\3:\4:\5:\6:\7/p')
     
     echo "Paquete mágico capturado para la dirección: \"${wake_mac}\""
     echo -n "Buscando una VM existente: "
     
     # Busca la dirección MAC en los archivos de configuración de VM.
     matches=($(grep -il ${wake_mac} /etc/pve/qemu-server/*))
     
     # Si no encuentra coincidencias en las VMs.
     if [[ ${#matches[*]} -eq 0 ]]; then
       echo "${#matches[*]} encontrado"
       
       # Busca la dirección MAC en los archivos de configuración de LXC.
       echo -n "Buscando un LXC existente: "
       matches=($(grep -il ${wake_mac} /etc/pve/lxc/*))
       
       # Si no encuentra coincidencias en los LXCs.
       if [[ ${#matches[*]} -eq 0 ]]; then
         echo "${#matches[*]} encontrado"
         continue  # Continúa con el siguiente ciclo.
       elif [[ ${#matches[*]} -gt 1 ]]; then
         echo "${#matches[*]} encontrado, usando el primero encontrado"
       else
         echo "${#matches[*]} encontrado"
       fi
       
       # Extrae el ID del contenedor LXC.
       vm_file=$(basename ${matches[0]})
       vm_id=${vm_file%.*}
       
       # Obtiene el estado y nombre del LXC.
       details=$(pct status ${vm_id} -verbose | egrep "^name|^status")
       name=$(echo ${details} | awk '{print $2}')
       status=$(echo ${details} | awk '{print $4}')
       
       # Si el LXC no está detenido, lo omite.
       if [[ "${status}" != "stopped" ]]; then
         echo "CONTENEDOR OMITIDO ${vm_id} : ${name} está ${status}"
       else
         # Si el LXC está detenido, lo inicia.
         echo "INICIANDO CONTENEDOR ${vm_id} : ${name} está ${status}"
         pct start ${vm_id}
       fi
       
       continue  # Continúa con el siguiente ciclo.
     elif [[ ${#matches[*]} -gt 1 ]]; then
       echo "${#matches[*]} encontrado, usando el primero encontrado"
     else
       echo "${#matches[*]} encontrado"
     fi
     
     # Extrae el ID de la VM.
     vm_file=$(basename ${matches[0]})
     vm_id=${vm_file%.*}
     
     # Obtiene el estado y nombre de la VM.
     details=$(qm status ${vm_id} -verbose | egrep "^name|^status")
     name=$(echo ${details} | awk '{print $2}')
     status=$(echo ${details} | awk '{print $4}')
     
     # Si la VM no está detenida, la omite.
     if [[ "${status}" != "stopped" ]]; then
       echo "VM OMITIDA ${vm_id} : ${name} está ${status}"
     else
       # Si la VM está detenida, la inicia.
       echo "INICIANDO VM ${vm_id} : ${name} está ${status}"
       qm start ${vm_id}
     fi
   done
   ```
5. Guarda el archivo y dale permisos de ejecución:
   ```bash
   chmod +x wol_hack.sh
   ```
6. Ejecuta el script para comenzar a monitorear los paquetes WOL y a iniciar automáticamente las VMs o LXCs correspondientes:
   ```bash
   ./wol_hack.sh
   ```

## Referencias

- [Proxmox Forum: Wake-on-LAN (WOL) for VMs and Containers](https://forum.proxmox.com/threads/wake-on-lan-wol-for-vms-and-containers.143879/)
