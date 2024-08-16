# Sincronización y Procesamiento de VMs desde un Servidor Remoto

![Estado: Completado](https://img.shields.io/badge/Estado-Completado-green)
![Versión: 1.1](https://img.shields.io/badge/Versión-1.1-blue)
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
   ```bash
   #!/bin/bash

   # Función para mostrar la ayuda
   mostrar_ayuda() {
       echo "Uso: $0 -s <conexión> -o <directorio1> -d <directorio2> [-h]"
       echo "  -s  Especifica la conexión SSH"
       echo "  -o Especifica el primer directorio de destino"
       echo "  -d Especifica el segundo directorio de destino"
       echo "  -h  Muestra esta ayuda"
       exit 1
   }

   # Leer los parámetros de la línea de comandos
   while getopts ":s:o:d:h" opt; do
       case $opt in
           s) CONN="$OPTARG" ;;
           o) DIR_1="$OPTARG" ;;
           d) DIR_2="$OPTARG" ;;
           h) mostrar_ayuda ;;
           \?) echo "Opción inválida: -$OPTARG" >&2; mostrar_ayuda ;;
       esac
   done

   # Verificar que todos los parámetros necesarios han sido proporcionados
   if [ -z "$CONN" ] || [ -z "$DIR_1" ] || [ -z "$DIR_2" ]; then
       echo "Error: Falta uno o más parámetros requeridos." >&2
       mostrar_ayuda
   fi

   # Realizar la sincronización de las VMs desde el servidor
   if ! rsync -avh --progress -e ssh "$CONN:/var/lib/vz/dump/" "$DIR_1"; then
       echo "Error durante la sincronización." >&2
       exit 1
   fi

   # Procesar archivos .log en el directorio de origen
   for log_file in "$DIR_1"/*.log; do
       # Obtener el nombre base del archivo sin la extensión
       base_name=$(basename "$log_file" .log)

       # Buscar todos los archivos relacionados con el nombre base
       files=$(find "$DIR_1" -name "${base_name}*")

       # Encontrar el archivo .notes
       notes_file=$(find "$DIR_1" -maxdepth 1 -name "${base_name}*.notes" -print -quit)

       if [ -n "$notes_file" ]; then
           # Leer el nombre de la VM del archivo .notes
           vm_name=$(<"$notes_file")

           # Crear el directorio destino usando el nombre de la máquina virtual
           vm_dir="$DIR_2/${vm_name}_${base_name}"
           mkdir -p "$vm_dir" || { echo "Error creando el directorio $vm_dir" >&2; exit 1; }

           # Mover los archivos relacionados al directorio de la máquina virtual
           for file in $files; do
               mv "$file" "$vm_dir" || { echo "Error moviendo el archivo $file" >&2; exit 1; }
           done

           # Comprimir el directorio con barra de progreso
           tar -cf - -C "$DIR_2" "${vm_name}_${base_name}" | pv -s $(du -sb "$DIR_2/${vm_name}_${base_name}" | awk '{print $1}') | gzip > "$DIR_2/${vm_name}_${base_name}.tar.gz"

           # Borrar el directorio original
           rm -rf "$vm_dir" || { echo "Error eliminando el directorio $vm_dir" >&2; exit 1; }
       else
           echo "Archivo .notes no encontrado para: $base_name"
       fi
   done
   ```
5. Guarda el archivo y dale permisos de ejecución:
   ```bash
   chmod +x sync_vms.sh
   ```
6. Ejecuta el script para sincronizar las VMs, procesar los archivos, y comprimir los datos:
   ```bash
   ./sync_vms.sh -s usuario@servidor -o /ruta/destino1 -d /ruta/destino2
   ```

## Referencias

- [Documentación de rsync](https://linux.die.net/man/1/rsync)
- [Documentación de tar](https://www.gnu.org/software/tar/manual/tar.html)
- [Página de Stack Overflow sobre scripts Bash para automatización](https://stackoverflow.com/questions/tagged/bash)
```
