# Sincronización y Procesamiento de VMs desde un Servidor Remoto

![Estado: Completado](https://img.shields.io/badge/Estado-Completado-green)
![Versión: 1.2](https://img.shields.io/badge/Versión-1.2-blue)
[![Autor: Lic. Ricardo MONLA](https://img.shields.io/badge/Autor-Lic.%20Ricardo%20MONLA-orange)](mailto:rmonla@gmail.com)

## Índice

1. [Descripción](#descripción)
2. [Procedimiento](#procedimiento)
3. [Referencias](#referencias)

## Descripción

Este script en Bash está diseñado para sincronizar las máquinas virtuales (VMs) desde un servidor remoto utilizando `rsync` sobre una conexión SSH. Posteriormente, procesa los archivos `.log` asociados con las VMs, crea directorios basados en los nombres de las máquinas virtuales extraídos de los archivos `.notes`, y finalmente comprime estos directorios en archivos `.tar.gz`. El script automatiza el flujo de trabajo de transferencia, organización y compresión de archivos relacionados con VMs en Proxmox, mejorando la eficiencia y la gestión de los recursos.

## Procedimiento

1. Abre una terminal en "Shell".
2. Navega a tu directorio personal y crea una carpeta para scripts:
   ```bash
   cd ~
   mkdir scripts
   cd scripts
   ```
3. Crea un archivo de script llamado `sync_vms.sh` y edítalo con `nano`:
   ```bash
   nano sync_vms.sh
   ```
4. Pega el siguiente código en el archivo y guárdalo:
  FALTA VERIFICAR FUNCIONAMIENTO
   ```bash

   #!/bin/bash

   # Mostrar ayuda
   mostrar_ayuda() { echo "Uso: $0 -s <conexión> -o <directorio1> -d <directorio2> [-h]"; exit 1; }
   
   # Leer parámetros
   while getopts ":s:o:d:h" opt; do
       case $opt in
           s) CONN="$OPTARG" ;; o) DIR_1="$OPTARG" ;; d) DIR_2="$OPTARG" ;; h|*) mostrar_ayuda ;;
       esac
   done
   
   # Verificar parámetros
   [ -z "$CONN" ] || [ -z "$DIR_1" ] || [ -z "$DIR_2" ] && mostrar_ayuda
   
   # Sincronizar VMs
   clear && echo "Iniciando sincronización..."
   rsync -avh --progress -e ssh "$CONN:/var/lib/vz/dump/" "$DIR_1" || { echo "Error durante la sincronización." >&2; exit 1; }
   
   # Procesar archivos
   for log_file in "$DIR_1"/*.log; do
       base_name=$(basename "$log_file" .log)
       notes_file=$(find "$DIR_1" -maxdepth 1 -name "${base_name}*.notes" -print -quit)
       [ -z "$notes_file" ] && { echo "Archivo .notes no encontrado para: $base_name"; continue; }
       
       vm_dir="$DIR_2/$(<"$notes_file")_${base_name}"
       mkdir -p "$vm_dir" || { echo "Error creando $vm_dir" >&2; exit 1; }
   
       mv "$DIR_1/${base_name}"* "$vm_dir" || { echo "Error moviendo archivos para $vm_dir"; exit 1; }
       echo "Comprimiendo $vm_dir ..."
       tar -cf - -C "$DIR_2" "$(basename "$vm_dir")" | pv -s $(du -sb "$vm_dir" | awk '{print $1}') | gzip > "${vm_dir}.tar.gz"
       rm -rf "$vm_dir" || { echo "Error eliminando $vm_dir" >&2; exit 1; }
   done
   
   ```
6. Guarda el archivo y dale permisos de ejecución:
   ```bash
   chmod +x sync_vms.sh
   ```
7. Ejecuta el script para sincronizar las VMs, procesar los archivos, y comprimir los datos:
   ```bash
   ./sync_vms.sh -s usuario@servidor -o /ruta/destino1 -d /ruta/destino2
   ```

## Referencias

- [Documentación de rsync](https://linux.die.net/man/1/rsync)
- [Documentación de tar](https://www.gnu.org/software/tar/manual/tar.html)
- [Página de Stack Overflow sobre scripts Bash para automatización](https://stackoverflow.com/questions/tagged/bash)
```
