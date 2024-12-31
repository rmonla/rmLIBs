# rm-xenExportVMs.sh

**Autor:** Ricardo MONLA ([GitHub](https://github.com/rmonla))  
**Descripción:** Este script permite exportar máquinas virtuales (VMs) desde un servidor XenServer y enviarlas directamente a un servidor remoto mediante SSH.

---

## Características
- **Exportación de máquinas virtuales:** Utiliza `xe vm-export` para exportar las VMs del XenServer.
- **Transferencia remota:** Envía los archivos exportados directamente al servidor remoto especificado mediante SSH.
- **Validación de estado de las VMs:** Solo exporta las VMs que están apagadas (`halted`).
- **Nombres seguros:** Limpia caracteres especiales de los nombres de las VMs para garantizar nombres de archivo válidos.
- **Logs y mensajes:** Proporciona información detallada sobre el proceso, incluyendo errores y resultados exitosos.

---

## Requisitos
- **Acceso root** en el servidor XenServer para ejecutar los comandos `xe`.
- **Conexión SSH** con el servidor remoto especificado.
- **Herramientas necesarias:**
  - `xe`
  - `ssh`
  - `awk`
  - `grep`
  - `sed`
  - `xargs`

---

## Variables principales

| Variable       | Descripción                                                                           |
|----------------|---------------------------------------------------------------------------------------|
| `DATE`         | Fecha y hora actual, utilizada para nombrar los archivos exportados.                 |
| `DEST_USER`    | Usuario SSH del servidor remoto.                                                     |
| `DEST_HOST`    | Dirección IP o nombre del host del servidor remoto.                                  |
| `DEST_PORT`    | Puerto SSH utilizado para la conexión remota.                                        |
| `DEST_DIR`     | Directorio remoto donde se guardarán los archivos exportados.                        |
| `CONEXION`     | Cadena combinada de usuario y host para establecer la conexión SSH.                  |

---

## Estructura del script

1. **Configuración inicial:**
   - Define variables de fecha, usuario, host, puerto, y directorio remoto.
2. **Listado de VMs:**
   - Ejecuta `xe vm-list` para obtener UUIDs y nombres de las VMs.
   - Filtra y procesa la salida para crear pares `nombre:UUID`.
3. **Exportación por cada VM:**
   - Limpia el nombre de la VM y verifica si está apagada.
   - Si está apagada, genera el nombre del archivo de exportación.
   - Exporta la VM y la transfiere al servidor remoto mediante SSH.
4. **Mensajes y logs:**
   - Informa al usuario sobre el progreso y los resultados de cada operación.

---

## Uso
1. Asegúrate de tener acceso SSH configurado correctamente al servidor remoto.
2. Copia el script `rm-xenExportVMs.sh` al servidor XenServer.
3. Ejecuta el script con permisos root:

   ```bash
   sudo ./rm-xenExportVMs.sh
   ```

4. Revisa los mensajes en la terminal para verificar el estado de las exportaciones y transferencias.

---

## Mensajes de salida
- **Éxito:**
  - *"Exportación y transferencia completadas: /ruta/al/archivo"*
- **Error:**
  - *"Error al exportar y transferir la VM 'nombre'."*
- **VM encendida:**
  - *"La VM 'nombre' está encendida (estado: running). No se exportará."*

---

## Notas
- Este script no verifica si el directorio remoto existe. Asegúrate de que el directorio especificado en `DEST_DIR` esté creado en el servidor remoto.
- Si el servidor remoto requiere autenticación con contraseña, deberás ingresarla al ejecutar el script.
- El script puede ser modificado para agregar funcionalidades como notificaciones por correo o generación de logs detallados.

---

## Licencia
Este script está bajo la [Licencia MIT](https://opensource.org/licenses/MIT).
