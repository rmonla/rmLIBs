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
# rmDocker|Portainer - Versión: 241229-1823

# Variables del Docker
dkrVARS=$(cat <<SHELL
dkrNOM="homepage"
dkrPORT=3000
dkrArchENV=".env"
appDirCFG="config"
dkrArchDkrComp="docker-compose.yml"

SHELL
)

# Procesar el contenido de dkrVARS y exportar las variables
eval "$(echo "$dkrVARS" | grep -E '^[a-zA-Z_][a-zA-Z0-9_]*=' | sed 's/^/export /')"

# Crear el directorio de despliegue
dirDKR="$(pwd)/$dkrNOM"
echo "Creando el directorio de despliegue: $dirDKR"
mkdir -p "$dirDKR" || { echo "Error al crear el directorio $dirDKR"; exit 1; }
# ---

# Crear el directorio de configuraciones de la aplicación
dirAppCFG="$dirDKR/$appDirCFG"
echo "Creando el directorio de despliegue: $dirAppCFG"
mkdir -p "$dirAppCFG" || { echo "Error al crear el directorio $dirAppCFG"; exit 1; }
# ---

# Archivo de variables de entorno de Docker
archENV="$dirDKR/$dkrArchENV" 
echo "Creando el archivo de variables de entorno $archENV"

tee "$archENV" <<-YAML || { echo "Error al escribir el archivo $archENV"; exit 1; }
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
# ---

# Archivo de despliegue de Docker
archDkrComp="$dirDKR/$dkrArchDkrComp"
echo "Creando el archivo de despliegue de Docker: $archDkrComp"

tee "$archDkrComp" <<-YAML || { echo "Error al escribir el archivo $archDkrComp"; exit 1; }
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
      - ./\${appDirCFG}:/app/config # Make sure your local config directory exists
      - /var/run/docker.sock:/var/run/docker.sock # (optional) For docker integrations, see alternative methods
    environment:
      PUID: \${PUID}
      PGID: \${PGID}
YAML
# ---

# Archivo de servicios de Homepage: services.yaml
archAppServs="$dirAppCFG/services.yaml"
echo "Creando el archivo de servicios de Homepage"

tee "$archAppServs" <<-YAML || { echo "Error al escribir el archivo $archAppServs"; exit 1; }
---
# For configuration options and examples, please see:
# https://gethomepage.dev/latest/configs/services
# icons found here https://github.com/walkxcode/dashboard-icons

- Hypervisor:
    - Proxmox:
        icon: proxmox.svg
        href: "{{HOMEPAGE_VAR_PROXMOX1_URL}}"
        description: pve1
        widget:
            type: proxmox
            url: "{{HOMEPAGE_VAR_PROXMOX1_URL}}"
            username:  "{{HOMEPAGE_VAR_PROXMOX1_USER}}"
            password:  "{{HOMEPAGE_VAR_PROXMOX1_API_KEY}}"
            node: xing-01
    - Proxmox:
        icon: proxmox.svg
        href: "{{HOMEPAGE_VAR_PROXMOX2_URL}}"
        description: pve2
        widget:
            type: proxmox
            url: "{{HOMEPAGE_VAR_PROXMOX2_URL}}"
            username:  "{{HOMEPAGE_VAR_PROXMOX2_USER}}"
            password:  "{{HOMEPAGE_VAR_PROXMOX2_API_KEY}}"
            node: xing-02
- Containers:
    - Portainer:
        icon: portainer.svg
        href: "{{HOMEPAGE_VAR_PORTAINER_URL}}"
        description: docker
        widget:
            type: portainer
            url: "{{HOMEPAGE_VAR_PORTAINER_URL}}"
            env: 2
            key: "{{HOMEPAGE_VAR_PORTAINER_API_KEY}}"
- Network:
    - UniFi:
        icon: unifi.svg
        href: "{{HOMEPAGE_VAR_UNIFI_NETWORK_URL}}"
        description: network
        widget:
            type: unifi
            url: "{{HOMEPAGE_VAR_UNIFI_NETWORK_URL}}"
            username:  "{{HOMEPAGE_VAR_UNIFI_NETWORK_USERNAME}}"
            password:  "{{HOMEPAGE_VAR_UNIFI_NETWORK_PASSWORD}}"
    - Uptime Kuma:
        icon: uptime-kuma.svg
        href: "{{HOMEPAGE_VAR_UPTIME_KUMA_URL}}"
        description: internal
        widget:
            type: uptimekuma
            url: "{{HOMEPAGE_VAR_UPTIME_KUMA_URL}}"
            slug: home
YAML
# ---

# Archivo de configuraciones de Homepage: settings.yaml
archAppConfs="$dirAppCFG/settings.yaml"
echo "Creando el archivo de configuraciones de Homepage"

tee "$archAppConfs" <<-YAML || { echo "Error al escribir el archivo $archAppConfs"; exit 1; }
---
# For configuration options and examples, please see:
# https://gethomepage.dev/latest/configs/settings

title: Techno Tim Homepage

background:
  image: https://cdnb.artstation.com/p/assets/images/images/006/897/659/large/mikael-gustafsson-wallpaper-mikael-gustafsson.jpg
  blur: sm # sm, md, xl... see https://tailwindcss.com/docs/backdrop-blur
  saturate: 100 # 0, 50, 100... see https://tailwindcss.com/docs/backdrop-saturate
  brightness: 50 # 0, 50, 75... see https://tailwindcss.com/docs/backdrop-brightness
  opacity: 100 # 0-100

theme: dark
color: slate

useEqualHeights: true

layout:
  Hypervisor:
    header: true
    style: row
    columns: 4
  Containers:
    header: true
    style: row
    columns: 4
  Network:
    header: true
    style: row
    columns: 4

YAML
# ---

# Ejecutar docker-compose
echo "Iniciando el contenedor con docker-compose..."
docker compose -f "$archDkrComp" up -d || { echo "Error al ejecutar docker-compose"; exit 1; }

# Mensaje de finalización
echo "${dkrNOM} se ha desplegado correctamente en http://0.0.0.0:${dkrPORT}/"

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
