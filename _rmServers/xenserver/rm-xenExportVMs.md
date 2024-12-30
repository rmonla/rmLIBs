Este script de Bash está diseñado para **exportar máquinas virtuales (VMs) desde un servidor XenServer y enviarlas directamente a un servidor remoto** usando SSH. A continuación, se detalla cómo funciona:
## rm-xenExportVMs.sh
```bash
#!/bin/bash
# Script para exportar máquinas virtuales de XenServer y enviarlas directamente a un destino remoto

# Configuración inicial
DATE=$(date +%Y_%m_%d-%H_%M_%S)       # Fecha actual
DEST_USER="rmonla"                    # Usuario SSH del destino
DEST_HOST="10.0.10.8"                 # Host SSH del destino
DEST_PORT="7022"                      # Puerto SSH del destino
DEST_DIR="/media/NS8_Disco2/bkps/srv_BKPs" # Directorio remoto donde guardar las exportaciones
CONEXION="${DEST_USER}@${DEST_HOST}"  # Cadena de conexión SSH

# Listar las máquinas virtuales y procesar la salida
sudo xe vm-list is-control-domain=false | grep -E "uuid|name-label" | awk -F ": " '
/uuid/ {uuid=$2} 
/name-label/ {print $2 ":" uuid}
' | while IFS=":" read -r vm_name vm_uuid; do
    # Limpiar espacios y caracteres especiales del nombre de la VM
    vm_name=$(echo "$vm_name" | xargs | sed 's/[^a-zA-Z0-9_-]/_/g')
    vm_uuid=$(echo "$vm_uuid" | xargs)
    
    # Verificar el estado de la VM
    vm_power_state=$(sudo xe vm-param-get uuid="$vm_uuid" param-name=power-state)
    if [ "$vm_power_state" != "halted" ]; then
        echo "La VM '$vm_name' (UUID: $vm_uuid) está encendida (estado: $vm_power_state). No se exportará."
        continue
    fi

    # Nombre del archivo remoto
    remote_file="${DEST_DIR}/${vm_name}_${DATE}.xva"
    
    # Informar al usuario sobre la exportación
    echo "Exportando y enviando VM '$vm_name' (UUID: $vm_uuid) al servidor remoto $CONEXION:$remote_file..."
    
    # Exportar y enviar directamente al servidor remoto usando el puerto especificado
    sudo xe vm-export vm="$vm_uuid" filename=| ssh -p "$DEST_PORT" "$CONEXION" "cat > '$remote_file'" && \
    echo "Exportación y transferencia completadas: $remote_file" || \
    echo "Error al exportar y transferir la VM '$vm_name'."
done
```

---

### **1. Configuración inicial**
- **Variables de fecha y conexión:**
  - Se define la fecha actual (`DATE`) para incluirla en el nombre del archivo exportado.
  - Configura el usuario (`DEST_USER`), host (`DEST_HOST`), puerto (`DEST_PORT`), y directorio destino (`DEST_DIR`) del servidor remoto.
- **Cadena de conexión SSH:** Combina usuario y host en `CONEXION`.

---

### **2. Listar máquinas virtuales**
- Utiliza el comando `xe vm-list` para listar todas las VMs excepto el dominio de control (`is-control-domain=false`).
- Filtra las líneas relevantes (`uuid` y `name-label`) y las procesa para obtener pares de nombre y UUID de cada VM usando `awk`.

---

### **3. Procesar cada VM**
- Por cada VM encontrada:
  1. **Limpia el nombre:** Reemplaza espacios y caracteres no válidos en el nombre de la VM con `_` para crear un nombre de archivo seguro.
  2. **Verifica el estado de la VM:** Consulta si la VM está encendida o apagada usando `xe vm-param-get`. Si la VM no está apagada (`halted`), se omite la exportación de esa VM.
  3. **Genera el nombre del archivo remoto:** Combina el nombre de la VM, la fecha actual y la extensión `.xva` para formar el nombre del archivo en el servidor remoto.

---

### **4. Exportar y transferir**
- Exporta la VM directamente al servidor remoto usando el comando `xe vm-export`.
  - La salida del comando (`filename=|`) se redirige a través de SSH al archivo remoto.
  - Utiliza `cat` en el servidor remoto para guardar la exportación en el directorio especificado.
- Informa si la operación fue exitosa o si hubo errores.

---

### **5. Comportamiento final**
- Si todo funciona correctamente:
  - Las VMs apagadas se exportan directamente al servidor remoto.
  - Las VMs encendidas no se procesan y se omiten con un mensaje.
- Proporciona feedback en tiempo real durante la ejecución.

---

### **¿Para qué se usa?**
- **Respaldo (Backup):** Exportar VMs para guardarlas en un servidor remoto como respaldo.
- **Migración:** Preparar y transferir VMs para ser restauradas en otro servidor.
- **Automatización:** Evitar la necesidad de exportar manualmente VMs una por una.

### **Puntos importantes**
- El script no comprueba si el directorio remoto existe.
- Es necesario tener acceso SSH al servidor remoto con las credenciales especificadas.
- Las VMs deben estar apagadas para exportarse.
