<!--  
# Ricardo MONLA (https://github.com/rmonla)
# rmDocker|Uptime Kuma - Versión: 250102-1827
-->
# <img src="https://github.com/louislam/uptime-kuma/raw/master/public/icon.png" alt="Dockge Logo" width="100"/>Dockge

Este documento explica cómo configurar un contenedor Docker para implementar **Dockge**, una herramienta autohospedada diseñada para la monitorización de sitios y servicios en tiempo real. Con un diseño moderno, intuitivo y altamente personalizable, Dockge permite a los usuarios supervisar la disponibilidad y el rendimiento de sus recursos críticos.

---

## Enlaces de Consulta

- 📚 Información del Aplicativo:
  - [Sitio Oficial](https://github.com/louislam/dockge)
  - [Repositorio en GitHub](https://github.com/louislam/dockge)
  - [Documentación Oficial](https://github.com/louislam/dockge)
- 🎥 Videos Recomendados:
  - [Dockge 1.0 - Release](https://youtu.be/AWAlOQeNpgU) - por **Louis**


---

## Características Destacadas

- **Monitorización avanzada:** Supervisa el estado de dispositivos Docker con eficiencia.
- **Diseño intuitivo:** Interfaz clara y moderna para gestionar múltiples servicios.
- **Implementación sencilla:** Configuración rápida con Docker Compose.
- **Solución autohospedada:** Mantén el control total de tus datos y configuración.
- **Compatibilidad:** Ideal para integrarse con otras herramientas como Uptime Kuma y Portainer.
---

## Requisitos Previos

- Docker y Docker Compose instalados en el sistema.
- Espacio suficiente en disco para datos persistentes.
- Acceso a los puertos necesarios para la interfaz web y los servicios monitorizados.

---

## Configuración e Implementación

### 1. Crear y Editar el Script `rmDkr-Deploy-UptimeKuma.sh`

Ejecuta el siguiente comando para crear el script de despliegue:

```bash
nano rmDkr-Deploy-UptimeKuma.sh
```

Copia y pega el siguiente contenido en el archivo:

```bash
#!/bin/bash
# Script para configurar y desplegar Uptime Kuma en Docker
# Ricardo MONLA (https://github.com/rmonla)
# rmDocker|Uptime Kuma - Versión: 250102-1827

# Variables del Docker
dkrVRS=$(cat <<YAML

dkrNOM=dockge
dkrPOR=5001

dkrArchENV=.env
dkrArchYML=docker-compose.yml

appDirDAT=data
YAML
)

dkrYML=$(cat <<YAML
services:
  dockge:
    image: louislam/dockge:1
    container_name: \${dkrNOM}
    restart: unless-stopped
    ports:
      - \${dkrPOR}:5001
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - ./\${appDirDAT}:/app/data
      - /opt/stacks:/opt/stacks
    environment:
      - DOCKGE_STACKS_DIR=/opt/stacks

YAML
)
# ---

# Procesar el contenido de dkrVRS y exportar las variables
eval "$(echo "$dkrVRS" | grep -E '^[a-zA-Z_][a-zA-Z0-9_]*=' | sed 's/^/export /')"
# ---

crear_directorio() {
    for newDir in "$@"; do
        echo "Creando el directorio $newDir"
        mkdir -p "$newDir" || { echo "Error al crear el directorio $newDir"; exit 1; }
    done
}

dirDKR="$(pwd)/$dkrNOM"

directorios=(
    "$dirDKR"
    "$dirDKR/$appDirDAT"
)

crear_directorio "${directorios[@]}"
# ---

escribir_archivo() {
    echo "Creando el archivo $2"
    echo "$1" > "$2" || { echo "Error al escribir $2"; exit 1; }
}
escribir_archivo "${dkrVRS}" "$dirDKR/$dkrArchENV" # Variables de entorno de Docker
escribir_archivo "${dkrYML}" "$dirDKR/$dkrArchYML" # Archivo de despliegue de Docker
# ---

# Ejecutar docker-compose
archDkrComp="$dirDKR/$dkrArchYML"
echo "Iniciando el contenedor con docker-compose..."
docker compose -f "$archDkrComp" up -d || { echo "Error al ejecutar docker-compose"; exit 1; }

# Mensaje de finalización
echo "${dkrNOM} se ha desplegado correctamente en http://0.0.0.0:${dkrPOR}/"

```
---

### 2. Ejecutar el Script de Despliegue

Guarda el archivo y ejecuta el script:

```bash
sh rmDkr-Deploy-UptimeKuma.sh
```

---

## Notas Adicionales

- **Detener el Contenedor:**
  Para detener y eliminar el contenedor, utiliza el comando:

  ```bash
  docker compose down
  ```

- **Actualizar Uptime Kuma:**
  Para actualizar a la última versión, ejecuta:

  ```bash
  docker compose pull && docker compose up -d
  ```

- **Personalización:**
  Consulta la [documentación oficial](https://github.com/louislam/uptime-kuma/wiki/) para ajustar configuraciones avanzadas y definir alertas personalizadas.

---
