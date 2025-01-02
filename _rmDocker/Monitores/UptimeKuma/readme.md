<!--  
# Ricardo MONLA (https://github.com/rmonla)
# rmDocker|Uptime Kuma - Versión: 250102-1706
-->
# <img src="https://github.com/louislam/uptime-kuma/raw/master/public/icon.png" alt="Uptime Kuma Logo" width="100"/>Uptime Kuma

Este documento explica cómo configurar un contenedor Docker para implementar **Uptime Kuma**, una herramienta autohospedada diseñada para la monitorización de sitios y servicios en tiempo real. Con un diseño moderno, intuitivo y altamente personalizable, Uptime Kuma permite a los usuarios supervisar la disponibilidad y el rendimiento de sus recursos críticos.

---

## Enlaces de Consulta

- 📚 Información del Aplicativo:
  - [Sitio Oficial de Uptime Kuma](https://uptime.kuma.pet/)
  - [Documentación Oficial](https://github.com/louislam/uptime-kuma/wiki/)
  - [Demo Oficial](https://demo.kuma.pet/start-demo)
- 🎥 Videos Recomendados:
  - [Uptime Kuma - Monitorización de dispositivos #Docker](https://www.youtube.com/watch?v=2dsOiz8Seoc) - por [**No Solo Hacking**](https://www.youtube.com/@NoSoloHacking)

---

## Características Destacadas

- **Monitorización en Tiempo Real:** Supervisa la disponibilidad y el rendimiento de sitios web y servicios.
- **Interfaz Intuitiva:** Diseño moderno y adaptable con soporte para temas claros y oscuros.
- **Alertas Personalizables:** Configura notificaciones a través de múltiples canales, como correo, Slack y Telegram.
- **Panel Centralizado:** Consolida el estado de todos tus recursos en una única interfaz.
- **Historial de Estado:** Acceso al historial completo de rendimiento y disponibilidad.
- **Autohospedado:** Control total sobre los datos y configuraciones de monitorización.
- **Multiplataforma:** Compatible con entornos Linux, macOS, Windows y contenedores Docker.

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
# rmDocker|Uptime Kuma - Versión: 250102-1706

# Variables del Docker
dkrVRS=$(cat <<YAML

dkrNOM=uptime-kuma
dkrPOR=3001

dkrArchENV=.env
dkrArchYML=docker-compose.yml

# appDirDAT=uptime-kuma-data
YAML
)

dkrYML=$(cat <<YAML
services:
  uptime-kuma:
    image: louislam/uptime-kuma:1
    container_name: \${dkrNOM}
    restart: always
    ports:
      - "\${dkrPOR}:3001"
    volumes:
      - uptime-kuma:/app/data
volumes:
  uptime-kuma:
    external: true
    name: uptime-kuma
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
    # "$dirDKR/$appDirCFG"
    # "$dirDKR/$appDirICO"
    # "$dirDKR/$appDirDAT"
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

# Crea el volumen externo
sudo docker volume create --name=uptime-kuma
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
