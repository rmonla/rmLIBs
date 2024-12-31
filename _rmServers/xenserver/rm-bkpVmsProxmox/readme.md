# Documentación del Script `rm-bkpVmsProxmox.sh`

## Autor
**Ricardo MONLA**
- [GitHub](https://github.com/rmonla)

## Descripción
El script `rm-bkpVmsProxmox.sh` permite sincronizar, procesar y comprimir backups de máquinas virtuales (VMs) desde un servidor remoto basado en Proxmox.

## Requisitos Previos
1. **Dependencias**:
   - `rsync`
   - `pv`
   - `tar`
   - `gzip`
2. **Permisos de SSH**: Configurar el acceso SSH al servidor remoto.
3. **Directorio del script**: El script asume que será ejecutado desde un directorio con permisos de escritura.

## Uso
### Sintaxis
```bash
./rm-bkpVmsProxmox.sh <conexión> [-h] [-v]
```
### Parámetros
- `<conexión>`: Dirección de conexión al servidor remoto (obligatorio).
- `-h`: Muestra la ayuda y sale.
- `-v`: Habilita la depuración del script.

### Ejemplo
```bash
./rm-bkpVmsProxmox.sh usuario@192.168.1.100 -v
```

## Funcionalidades
### 1. **Ayuda y Validación**
- Muestra un mensaje de ayuda si se utiliza la opción `-h`.
- Valida que se proporcione al menos un argumento obligatorio (dirección de conexión).
- Comprueba la instalación de la herramienta `pv`.

### 2. **Sincronización de Backups**
- Utiliza `rsync` para sincronizar los archivos desde el directorio remoto `/var/lib/vz/dump/` hacia una carpeta local (`_sync_data`).

### 3. **Procesamiento de Archivos**
- Itera sobre los archivos `.log` sincronizados.
- Valida la existencia y contenido de los archivos `.log` y `.notes`.
- Extrae el nombre de la VM desde los archivos `.notes` y lo utiliza para renombrar los archivos asociados.
- Organiza los archivos en directorios individuales para cada VM.

### 4. **Compresión**
- Comprime los archivos procesados utilizando `tar` y `gzip`, con barra de progreso proporcionada por `pv`.

### 5. **Limpieza**
- Elimina los directorios temporales utilizados durante el procesamiento.

## Directorios
- `dirHOME`: Directorio base donde se encuentra el script.
- `dirSYNC`: Carpeta temporal para sincronización de archivos.
- `dirPROC`: Carpeta donde se almacenan los archivos comprimidos.

## Gestión de Errores
- Verifica errores en cada etapa del proceso (sincronización, compresión, limpieza) y muestra mensajes detallados en caso de fallos.
- Omite archivos sin correspondencia válida, mostrando advertencias.

## Notas
- Se recomienda ejecutar el script con permisos suficientes para lectura y escritura en los directorios definidos.
- Asegúrese de que el servidor remoto tenga habilitado el acceso SSH y los backups estén disponibles en `/var/lib/vz/dump/`.

## Próximos Pasos
- Mejorar la validación de archivos.
- Agregar opciones para personalizar rutas y configuraciones.
- Incluir soporte para más formatos de compresión.

