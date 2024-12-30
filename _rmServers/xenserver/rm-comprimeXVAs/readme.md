# Script para Compresión de Archivos .xva

## Descripción
Este script en Bash permite comprimir archivos con extensión `.xva` en el directorio actual. Ofrece dos modos de operación:

1. **Modo Asistido (Por defecto):** Solicita la interacción del usuario para seleccionar el archivo a comprimir, el directorio de destino y confirmar si desea eliminar el archivo original.
2. **Modo Silencioso:** Comprime todos los archivos `.xva` en el directorio actual y elimina los originales sin interacción del usuario.

## Características
- **Interfaz de Menú:** Permite seleccionar archivos y directorios mediante un menú interactivo.
- **Creación de Directorios:** Posibilidad de crear nuevos directorios de destino para las compresiones.
- **Barra de Progreso:** Muestra el progreso de la compresión.
- **Confirmación de Eliminación:** Opcional en modo asistido; automática en modo silencioso.

## Uso
### Sintaxis
```bash
./rm-comprimeXVAs.sh [-s]
```

### Opciones
- `-s`: Activa el modo silencioso. En este modo, el script:
  - Comprime todos los archivos `.xva` en el directorio actual.
  - Guarda los archivos comprimidos en el mismo directorio.
  - Elimina los archivos originales después de la compresión.

### Ejecución en Modo Asistido
1. Ejecuta el script sin parámetros:
   ```bash
   ./rm-comprimeXVAs.sh
   ```
2. Sigue las instrucciones en pantalla para seleccionar archivos y directorios.

### Ejecución en Modo Silencioso
1. Ejecuta el script con la opción `-s`:
   ```bash
   ./rm-comprimeXVAs.sh -s
   ```
2. El script procesará todos los archivos `.xva` en el directorio actual.

## Requisitos
- **Dependencias:**
  - `pv`: Para mostrar la barra de progreso durante la compresión.
  - `tar`: Para comprimir los archivos.
  - `du`: Para calcular el tamaño de los archivos.
- **Permisos:**
  - El usuario debe tener permisos de lectura y escritura en los directorios de origen y destino.

## Ejemplo
### Modo Asistido
```bash
./rm-comprimeXVAs.sh
```
1. Selecciona un archivo `.xva`.
2. Selecciona o crea un directorio de destino.
3. Confirma si deseas eliminar el archivo original después de la compresión.

### Modo Silencioso
```bash
./rm-comprimeXVAs.sh -s
```
1. El script localizará todos los archivos `.xva` en el directorio actual.
2. Comprimirá cada archivo al formato `.tar.gz`.
3. Eliminará los archivos originales.

## Notas
- Si no hay archivos `.xva` en el directorio actual, el script finalizará con un mensaje de error.
- El script creará automáticamente el directorio de destino si este no existe.

---
**Autor:** Ricardo MONLA (https://github.com/rmonla)  
**Fecha:** 30 de Diciembre de 2024

