# <img src="https://homarr.dev/img/logo.png" alt="Homarr Logo" width="100"/> Homarr
<!--  
# Ricardo MONLA (https://github.com/rmonla)
# rmDocker|Homarr - Versión: 250102-1429
-->
Este documento explica cómo configurar un contenedor Docker para implementar **Homearr**, una solución moderna y eficiente diseñada para centralizar la gestión de servicios en redes domésticas o empresariales. Homearr optimiza la experiencia del usuario al proporcionar un dashboard intuitivo para acceder y organizar diversas aplicaciones y servicios.

---
## Enlaces de Consulta

- 📚 Información del Aplicativo:
  - [Sitio Oficial de Homearr](https://homarr.dev/)
  - [Repositorio en GitHub](https://github.com/ajnart/homarr)
  - [Documentación Oficial](https://homarr.dev/)
- 🎥 Videos Recomendados:
  - [my FAVORITE Home Server Dashboard - Homarr Setup in Docker](https://youtu.be/A6vcTIzp_Ww?si=j4d0gjg9yrzVLnv5) - por [**TechHut**](https://www.youtube.com/@TechHut)

---

## Características Destacadas

- **Interfaz unificada:** Consolida múltiples servicios en un solo panel accesible y organizado.
- **Compatibilidad extensa:** Compatible con populares aplicaciones de gestión como Sonarr, Radarr, Plex, y más.
- **Automatización eficiente:** Configura flujos de trabajo automatizados para simplificar tareas repetitivas.
- **Alta personalización:** Ofrece widgets y herramientas ajustables según las necesidades del usuario.
- **Seguridad robusta:** Controles de acceso avanzados y cifrado para proteger la información.
- **Multiplataforma:** Disponible para Linux, macOS, Windows y en entornos Docker.

---

## Requisitos Previos

- Docker y Docker Compose instalados en el sistema.
- Conexión estable a internet para descargar imágenes de contenedor.
- Espacio suficiente en disco para datos persistentes.
- Acceso al puerto configurado para la interfaz web.

---

## Configuración e Implementación

### 1. Crear y Editar el Script `rmDkr-Deploy-Homearr.sh`

Ejecuta el siguiente comando para crear el script de despliegue:

```bash
nano rmDkr-Deploy-Homearr.sh
```

Copia y pega el siguiente contenido en el archivo:

```bash
#!/bin/bash
# Script para configurar y desplegar Homarr en Docker
# Ricardo MONLA (https://github.com/rmonla)
# rmDocker|Homarr - Versión: 250102-1436

# Variables del Docker
dkrVRS=$(cat <<YAML

dkrNOM=homarr
dkrPOR=7575

dkrArchENV=.env
dkrArchYML=docker-compose.yml

appDirCFG=configs
appDirICO=icons
appDirDAT=data
YAML
)

dkrYML=$(cat <<YAML
services:
  homarr:
    image: ghcr.io/ajnart/homarr:latest
    container_name: \${dkrNOM}
    ports:
      - '\${dkrPOR}:7575'
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock # Integración opcional con Docker
      - ./\${appDirCFG}:/app/data/configs
      - ./\${appDirICO}:/app/public/icons
      - ./\${appDirDAT}:/data
    restart: unless-stopped

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
    "$dirDKR/$appDirCFG"
    "$dirDKR/$appDirICO"
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
# ---

# Mensaje de finalización
echo "${dkrNOM} se ha desplegado correctamente en http://0.0.0.0:${dkrPOR}/"

```
---
### 2. Ejecutar el Script de Despliegue

Guarda el archivo y ejecuta el script:

```bash
sh rmDkr-Deploy-Homearr.sh
```

---

## Notas Adicionales

- **Detener el Contenedor:**
  Para detener y eliminar el contenedor, utiliza el comando:

  ```bash
  docker compose down
  ```

- **Actualizar Homearr:**
  Para actualizar a la última versión, ejecuta:

  ```bash
  docker compose pull && docker compose up -d
  ```

- **Personalización:**
  Consulta la [documentación oficial](https://docs.homearr.io/) para ajustar widgets, temas y servicios según tus necesidades.

---