# Copiar VM de un Proxmox a Otro

![Estado: Estable](https://img.shields.io/badge/Estado-En%20Estudio-green)
![Versión: 1.1](https://img.shields.io/badge/Versión-1.1-blue)
[![Autor: Lic. Ricardo MONLA](https://img.shields.io/badge/Autor-Lic.%20Ricardo%20MONLA-orange)](mailto:rmonla@gmail.com)

## Índice

1. [Descripción](#descripción)
2. [Objetivo](#objetivo)
3. [Procedimiento](#procedimiento)
4. [Referencias](#referencias)

## Descripción

Este documento proporciona instrucciones detalladas sobre cómo copiar una máquina virtual (VM) de un entorno Proxmox a otro. Se describen los pasos necesarios para lograr una copia exitosa, incluyendo los ajustes y configuraciones recomendados. 

## Objetivo

El objetivo principal es permitir a los usuarios migrar máquinas virtuales entre diferentes nodos Proxmox de manera eficiente y sin perder configuraciones críticas.

## Procedimiento

1. Seleccionar y detener la VM.
2. Generar una copia de seguridad en el servidor de origen.
3. Transferir la copia mediante SCP o herramientas similares desde el servidor de origen al destino, utilizando el directorio `/var/lib/vz/dump` en ambos servidores.
```
scp vzdump-qemu-101-2023_08_25* root@10.0.10.200:/var/lib/vz/dump
```

## Referencias

- [Cómo respaldar y transferir una máquina virtual Proxmox a otro servidor](http://somebooks.es/como-respaldar-y-transferir-una-maquina-virtual-proxmox-a-otro-servidor/)
