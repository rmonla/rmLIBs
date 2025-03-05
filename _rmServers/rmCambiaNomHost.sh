#!/bin/bash
# Script para cambiar el nombre del host y reiniciar el sistema
# Ricardo Monla (https://github.com/rmonla)
# rmCambiaNomHost.sh - v250305-2021


clear

# Mostrar el nombre del host actual
H_ACTUAL=$(hostname)
echo "Nombre del host actual: $H_ACTUAL"

# Solicitar el nuevo nombre de host
printf "Ingresa el nuevo nombre de host: "
read H_NUEVO

# Validar que se ingresó un nombre
if [ -z "$H_NUEVO" ]; then
  echo "Error: No ingresaste un nombre de host válido."
  exit 1
fi

# Cambiar el nombre del host en los archivos de configuración y reiniciar
sudo sed -i "s/$H_ACTUAL/$H_NUEVO/g" /etc/hosts /etc/hostname && sudo reboot
