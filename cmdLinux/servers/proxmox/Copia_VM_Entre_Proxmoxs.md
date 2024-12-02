# Copia VM de un Proxmox a Otro

![Estado: Estable](https://img.shields.io/badge/Estado-Estable-green) ![Versión: 1.3](https://img.shields.io/badge/Versión-1.3-blue) [![Autor: Lic. Ricardo MONLA](https://img.shields.io/badge/Autor-Lic.%20Ricardo%20MONLA-orange)](mailto:rmonla@gmail.com)

## 📋 Índice

1. [Descripción](#descripción)
2. [Procedimiento](#procedimiento)
3. [Referencias](#referencias)

## 📝 Descripción

Este documento proporciona instrucciones detalladas sobre cómo copiar una máquina virtual (VM) de un entorno Proxmox a otro. Se describen los pasos necesarios para lograr una copia exitosa, incluyendo los ajustes y configuraciones recomendados. 

## ⚙️ Procedimiento

### 1. Seleccionar y detener la VM

Primero, debes identificar la máquina virtual (VM) que deseas copiar en el entorno Proxmox. Accede a la interfaz web de Proxmox y selecciona la VM en cuestión desde la lista de máquinas virtuales.

**Pasos**:
- Accede a la interfaz web de Proxmox.
- En el menú de la izquierda, selecciona el nodo donde se encuentra la VM.
- Haz clic en la VM para seleccionarla.
  
![Selección de la VM en Proxmox](https://example.com/imagen_seleccion_vm.png)

**Detener la VM**:
- Ve a la pestaña `Summary` (Resumen) y haz clic en `Shutdown` para detener la VM. Esto es necesario para asegurar que la copia sea consistente.

    ![Detener la VM](https://example.com/imagen_shutdown_vm.png)

### 2. Generar una copia de seguridad en el servidor de origen

Una vez que la VM esté detenida, el siguiente paso es generar una copia de seguridad (backup) de la misma. Esta copia es la que se transferirá al nuevo servidor.

**Pasos**:
- En la interfaz de Proxmox, selecciona la VM y ve a la pestaña `Backup` (Copia de seguridad).
- Haz clic en `Backup now` para iniciar el proceso de copia de seguridad.
  
![Generar copia de seguridad](https://example.com/imagen_backup_vm.png)

**Configuración de Backup**:
- Elige el almacenamiento donde se guardará la copia.
- Selecciona el modo de copia (puede ser `Snapshot` o `Stop` dependiendo de tus necesidades).
- Haz clic en `Start` para iniciar el backup.

    ![Configuración de Backup](https://example.com/imagen_backup_settings.png)

La copia de seguridad se guardará en el directorio `/var/lib/vz/dump` del servidor de origen, lista para ser transferida al servidor de destino.

### 3. Transferir la copia mediante SCP o herramientas similares desde el servidor de origen al destino, utilizando el directorio `/var/lib/vz/dump` en ambos servidores.

```bash
scp vzdump-qemu* root@10.0.10.200:/var/lib/vz/dump
```

## 🔗 Referencias

- [Cómo respaldar y transferir una máquina virtual Proxmox a otro servidor](http://somebooks.es/como-respaldar-y-transferir-una-maquina-virtual-proxmox-a-otro-servidor/)
