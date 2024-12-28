# <img src="https://github.com/gethomepage/homepage/raw/dev/images/banner_light@2x.png" alt="Homepage Logo" /> Homepage

Este documento detalla la configuración de un contenedor Docker para implementar **Homepage**, una solución versátil diseñada para centralizar y personalizar el acceso a aplicaciones, servicios y herramientas utilizadas en entornos de servidores y redes domésticas o empresariales. Con una interfaz moderna y fácil de usar, Homepage permite organizar y monitorizar eficientemente diversos sistemas y servicios.

---

### Enlaces de consulta:
- 📚 Información del Aplicativo:
  - [Sitio Oficial de Homepage](https://gethomepage.dev/)
  - [GitHub](https://github.com/gethomepage/homepage)
  - [Documentación oficial](https://gethomepage.dev/)
- 🎥 Videos recomendados:
  - [Meet Homepage - Your HomeLab Services Dashboard](https://youtu.be/oia6WqcOipU?si=Q5zA9J_Y4egr7KdD) - por [**Techno Tim**](https://www.youtube.com/@TechnoTim)

---

### Características destacadas

- **Dashboard centralizado:** Proporciona un tablero único y personalizable para acceder a aplicaciones, servicios y herramientas.
- **Interfaz moderna y adaptativa:** Optimizada para dispositivos móviles y navegadores, con temas claros y oscuros.
- **Fácil implementación:** Instalación rápida con soporte para Docker, simplificando la configuración y el despliegue.
- **Alta personalización:** Ofrece soporte para widgets, accesos directos y configuraciones personalizadas para ajustarse a cualquier necesidad.
- **Integraciones amplias:** Compatible con una variedad de servicios como Sonarr, Radarr, Plex, y muchos más.
- **Gestión eficiente:** Reduce la necesidad de múltiples accesos independientes al consolidarlos en una sola herramienta.
- **Soporte multiplataforma:** Funciona en Linux, macOS, Windows y entornos virtualizados o en contenedores Docker.

---

## Requisitos Previos

- Docker y Docker Compose instalados en el sistema.
- Espacio en disco suficiente para almacenar datos persistentes.
- Acceso al puerto definido para la interfaz web.

---
### 1. **Archivo `rmDkr-Deploy-Homepage.sh`**
```bash
    nano rmDkr-Deploy-Homepage.sh
```

```bash
#!/bin/bash
# Script para configurar y desplegar Homepage en Docker
# Versión: 241228-1020

# Definir la variable dkrVARS
dkrVARS=$(cat <<-SHELL
# Variables del Docker
dkrNOM="homepage"
dkrPORT=3000
dkrDirCFG="./config"
dkrArchENV=".env"
SHELL
)

# Procesar el contenido de dkrVARS y exportar las variables
eval "$(echo "$dkrVARS" | grep -E '^[a-zA-Z_][a-zA-Z0-9_]*=' | sed 's/^/export /')"

# Código del archivo .env
codArchENV=$(cat <<-YAML

${dkrVARS}

PUID=1000
PGID=1000

HOMEPAGE_VAR_PROXMOX1_URL=
HOMEPAGE_VAR_PROXMOX1_USER=
HOMEPAGE_VAR_PROXMOX1_API_KEY=

HOMEPAGE_VAR_PROXMOX2_URL=
HOMEPAGE_VAR_PROXMOX2_USER=
HOMEPAGE_VAR_PROXMOX2_API_KEY=

HOMEPAGE_VAR_PORTAINER_URL=
HOMEPAGE_VAR_PORTAINER_API_KEY=

HOMEPAGE_VAR_UNIFI_NETWORK_URL=
HOMEPAGE_VAR_UNIFI_NETWORK_USERNAME=
HOMEPAGE_VAR_UNIFI_NETWORK_PASSWORD=

HOMEPAGE_VAR_UPTIME_KUMA_URL=

YAML
)


# Configuración del archivo docker-compose
codArchDkrComp=$(cat <<YAML
version: "3.3"
services:
  homepage:
    image: ghcr.io/gethomepage/homepage:latest
    container_name: \${dkrNOM}
    restart: unless-stopped
    ports:
      - \${dkrPORT}:3000
    env_file: \${dkrArchENV}
    volumes:
      - \${dkrDirCFG}:/app/config # Make sure your local config directory exists
      - /var/run/docker.sock:/var/run/docker.sock # (optional) For docker integrations, see alternative methods
    environment:
      PUID: \${PUID}
      PGID: \${PGID}

YAML
)

# Variables del Despliegue

# Crear el directorio de despliegue
dirDKR="$(pwd)/$dkrNOM"
echo "Creando el directorio de despliegue: $dirDKR"
mkdir -p "$dirDKR" || { echo "Error al crear el directorio $dirDKR"; exit 1; }

# Escribir el archivo .env
archENV="$dirDKR/.env"
echo "Creando el archivo docker-compose.yml en $archENV"
echo "$codArchENV" | tee "$archENV" > /dev/null || { echo "Error al escribir el archivo .env"; exit 1; }

# Escribir el archivo docker-compose.yaml
archYAML="$dirDKR/docker-compose.yaml"
echo "Creando el archivo docker-compose.yml en $archYAML"
echo "$codArchDkrComp" | tee "$archYAML" > /dev/null || { echo "Error al escribir el archivo docker-compose.yml"; exit 1; }

# Ejecutar docker-compose
echo "Iniciando el contenedor con docker-compose..."
docker compose -f "$archYAML" up -d || { echo "Error al ejecutar docker-compose"; exit 1; }

# Mensaje de finalización
echo "Homarr se ha desplegado correctamente en http://localhost:${dkrPORT}"

```


### Notas Adicionales

- **Detener el Contenedor:**
  Para detener y eliminar el contenedor, utiliza el comando:

  ```bash
  docker-compose down
  ```

- **Actualizaciones:**
  Para actualizar Homepage a la última versión, ejecuta:

  ```bash
  docker-compose pull && docker-compose up -d
  ```

- **Personalización:**
  Explora la documentación oficial para ajustar widgets, temas y accesos directos según tus necesidades.

---
