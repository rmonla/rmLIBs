#!/bin/bash
# Script para configurar y desplegar Homepage en Docker
# Ricardo MONLA (https://github.com/rmonla)
# Versión: 250109-1429 - rmDocker|Homepage|rmDkrUp-Homepage.sh

# Variables del Docker
dkrVRS=$(cat <<YAML

dkrNOM=homepage
dkrPOR=3000

dkrArchENV=.env
dkrArchYML=docker-compose.yml

appDirCFG=config
YAML
)

dkrYML=$(cat <<YAML
services:
  homepage:
    image: ghcr.io/gethomepage/homepage:latest
    container_name: \${dkrNOM}
    environment:
      PUID: 1000 # optional, your user id
      PGID: 1000 # optional, your group id
    ports:
      - \${dkrPOR}:3000
    volumes:
      - ./\${appDirCFG}:/app/config # Make sure your local config directory exists
      - /var/run/docker.sock:/var/run/docker.sock:ro # optional, for docker integrations
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
    # "$dirDKR"
    "$dirDKR/$appDirCFG"
)

crear_directorio "${directorios[@]}"
# ---

escribir_archivo() {
    echo "Creando el archivo $2"
    echo "$1" > "$2" || { echo "Error al escribir $2"; exit 1; }
}
escribir_archivo "${dkrVRS}" "$dirDKR/$dkrArchENV" # Variables de entorno de Docker
escribir_archivo "${dkrYML}" "$dirDKR/$dkrArchYML" # Archivo de despliegue de Docker
# escribir_archivo "# Versión: 250105-22323 - rmDocker|Homepage|rmDkrUp-Homepage.sh" "$dirDKR/$appArchCFG" # Archivo de despliegue de Docker
# ---

# Ejecutar docker-compose
archDkrComp="$dirDKR/$dkrArchYML"
echo "Iniciando el contenedor con docker-compose..."
docker compose -f "$archDkrComp" up -d || { echo "Error al ejecutar docker-compose"; exit 1; }

# Mensaje de finalización
echo "${dkrNOM} se ha desplegado correctamente en http://0.0.0.0:${dkrPOR}/"
