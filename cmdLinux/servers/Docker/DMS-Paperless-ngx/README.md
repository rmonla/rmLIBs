# Paperless-ngx
![](./paperless-ngx-banner.png)

**Paperless-ngx** es un sistema de gestión de documentos de código abierto diseñado para digitalizar, organizar y buscar documentos de forma eficiente. Permite a los usuarios escanear, almacenar y gestionar documentos electrónicos, proporcionando características como la indexación automática, el reconocimiento óptico de caracteres (OCR) y un sistema de búsqueda avanzado. Es ideal para individuos y organizaciones que buscan una solución accesible y personalizable para gestionar sus archivos digitales de manera ordenada y segura.

## rm_dkr_install:
Este script automatiza la configuración y el despliegue de **Paperless-ngx** en contenedores Docker.

```shell
# rm_dkr_install_v-3.1

# [Paperless-ngx - Docker Hub](https://hub.docker.com/r/linuxserver/paperless-ngx)
# [Iniciar --> http://localhost:8010 admin:admin

# Variables de configuración
DKR_NOM="paperless-ngx" # ${DKR_NOM} Nombre del contenedor
DKR_POR="8010"          # ${DKR_POR} Puerto del contenedor
DKR_DIR="/docker/$DKR_NOM"
DKR_YML="$DKR_DIR/docker-compose.yml"

# Cadena con la configuración del archivo docker-compose
DKR_CFG=$(cat <<-EOF
---
version: "2.1"
services:
  ${DKR_NOM}:
    image: lscr.io/linuxserver/paperless-ngx:latest
    container_name: ${DKR_NOM}
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=America/Argentina/La_Rioja
      - REDIS_URL= # optional
    volumes:
      - /path/to/appdata/config:/config
      - /path/to/appdata/data:/data
    ports:
      - ${DKR_POR}:8000
    restart: unless-stopped
EOF
)

# Crear directorio y archivo docker-compose con la configuración
sudo mkdir -p "$DKR_DIR" && echo "$DKR_CFG" | sudo tee "$DKR_YML" > /dev/null

# Ejecutar docker-compose
sudo docker-compose -f "$DKR_YML" up -d
```
