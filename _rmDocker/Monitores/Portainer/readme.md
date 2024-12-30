# <img src="https://www.portainer.io/hubfs/portainer-logo-white-1.svg" alt="Portainer Logo" width="50%"/>

Este documento explica cómo configurar un contenedor Docker para implementar **Portainer**, una solución moderna y altamente personalizable diseñada para centralizar y gestionar accesos a aplicaciones, servicios y herramientas. Ideal para entornos de servidores y redes domésticas o empresariales, Portainer ofrece una interfaz intuitiva y organizada para optimizar la productividad.

---

## Enlaces de Consulta

- 📚 Información del Aplicativo:
  - [Sitio Oficial de Portainer](https://www.portainer.io/)
  - [Repositorio en GitHub](https://github.com/portainer/portainer)
  - [Documentación Oficial](https://docs.portainer.io/)
- 🎥 Videos Recomendados:
  - [Meet Portainer - Your HomeLab Services Dashboard](https://www.youtube.com/watch?v=mC3tjysJ01E) - por [**Techno Tim**](https://www.youtube.com/@TechnoTim)

---

## Características Destacadas

- **Dashboard centralizado:** Consolida el acceso a todas tus aplicaciones y servicios en un único panel intuitivo.
- **Interfaz moderna y adaptativa:** Diseño optimizado para dispositivos móviles y navegadores con soporte para temas claros y oscuros.
- **Fácil implementación:** Configuración rápida y sencilla utilizando Docker y Docker Compose.
- **Personalización avanzada:** Soporte para widgets, accesos directos y configuraciones adaptadas a tus necesidades.
- **Amplia compatibilidad:** Compatible con servicios populares como Sonarr, Radarr, Plex, Proxmox, Portainer, Uptime Kuma y más.
- **Gestión eficiente:** Reduce la complejidad al unificar múltiples accesos independientes.
- **Multiplataforma:** Funciona en Linux, macOS, Windows y entornos virtualizados o en contenedores Docker.

---

## Requisitos Previos

- Docker y Docker Compose instalados en el sistema.
- Espacio suficiente en disco para datos persistentes.
- Acceso al puerto definido para la interfaz web.

---

## Configuración e Implementación

### 1. Crear y Editar el Script `rmDkr-Deploy-Portainer.sh`

Ejecuta el siguiente comando para crear el script de despliegue:

```bash
nano rmDkr-Deploy-Portainer.sh
```

Copia y pega el siguiente contenido en el archivo:

```bash
#!/bin/bash
# Script para configurar y desplegar Portainer en Docker
# Ricardo MONLA (https://github.com/rmonla)
# rmDocker|Portainer - Versión: 241229-2000

# Variables del Docker
dkrVRS=$(cat <<YAML

dkrNOM=portainer
dkrPOR=9000

dkrArchENV=.env
dkrArchYML=docker-compose.yml

appDirDAT=portainer-data

# appDirCFG=config
YAML
)

dkrYML=$(cat <<YAML
version: '3'
services:
  portainer:
    image: portainer/portainer-ce:latest
    container_name: \${dkrNOM}
    restart: unless-stopped
    security_opt:
      - no-new-privileges:true
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - ./\${appDirDAT}:/data
    ports:
      - \${dkrPOR}:9000

YAML
)-

# Procesar el contenido de dkrVRS y exportar las variables
eval "$(echo "$dkrVRS" | grep -E '^[a-zA-Z_][a-zA-Z0-9_]*=' | sed 's/^/export /')"

crear_directorio() {
    echo "Creando el directorio $1"
    mkdir -p "$1" || { echo "Error al crear el directorio $1"; exit 1; }
}
crear_directorio "$(pwd)/$dkrNOM"     # Crea directorio del Docker.
crear_directorio "$dirDKR/$appDirDAT" # Crea directorio de de configuraciones de la aplicación.
# ---

escribir_archivo() {
    echo "Creando el archivo $2"
    echo "$1" > "$2" || { echo "Error al escribir $2"; exit 1; }
}
escribir_archivo "${dkrVRS}" "$dirDKR/$dkrArchENV" # Variables de entorno de Docker
escribir_archivo "${dkrYML}" "$dirDKR/$dkrArchYML" # Archivo de despliegue de Docker
# ---

# Ejecutar docker-compose
echo "Iniciando el contenedor con docker-compose..."
docker compose -f "$archDkrComp" up -d || { echo "Error al ejecutar docker-compose"; exit 1; }

# Mensaje de finalización
echo "${dkrNOM} se ha desplegado correctamente en http://0.0.0.0:${dkrPOR}/"

```

### 2. Ejecutar el Script de Despliegue

Guarda el archivo y ejecuta el script:

```bash
sh rmDkr-Deploy-Homepage.sh
```

---

## Notas Adicionales

- **Detener el Contenedor:**
  Para detener y eliminar el contenedor, utiliza el comando:

  ```bash
  docker compose down
  ```

- **Actualizar Homepage:**
  Para actualizar a la última versión, ejecuta:

  ```bash
  docker compose pull && docker compose up -d
  ```

- **Personalización:**
  Consulta la [documentación oficial](https://gethomepage.dev/latest/configs) para ajustar widgets, temas y servicios según tus necesidades.

---
# Ricardo MONLA (https://github.com/rmonla)
# rmDocker|Portainer - Versión: 241229-1824