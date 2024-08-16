# Copiar VM de un Proxmox a Otro

![Estado: EnProceso](https://img.shields.io/badge/Estado-EnProceso-gray)
![Versión: 0.1](https://img.shields.io/badge/Versión-0.1-blue)
[![Autor: Lic. Ricardo MONLA](https://img.shields.io/badge/Autor-Lic.%20Ricardo%20MONLA-orange)](mailto:rmonla@gmail.com)

## Índice

1. [Descripción](#descripción)
3. [Procedimiento](#procedimiento)
4. [Referencias](#referencias)

## Descripción

Este script está diseñado para escuchar paquetes Wake-on-LAN (WoL) en una interfaz específica, identificar la dirección MAC de origen, y si encuentra una VM o LXC en Proxmox con esa MAC, intenta iniciarla si está detenida. Los comentarios en español deberían ayudarte a entender lo que hace cada parte del script. ¡Si tienes más preguntas, no dudes en preguntar!

## Create Wake-On-LAN script

1. Click on your Proxmox Node and go to "Shell"​
2. Type in cd ~ followed by mkdir scripts, then navigate into that folder with cd scripts​
3. Next type in nano wol_hack.sh and paste the following script into that file (credit goes to @henr0 - Source):​
   
```
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

## Referencias

- [https://forum.proxmox.com/threads/wake-on-lan-wol-for-vms-and-containers.143879/](https://forum.proxmox.com/threads/wake-on-lan-wol-for-vms-and-containers.143879/)
