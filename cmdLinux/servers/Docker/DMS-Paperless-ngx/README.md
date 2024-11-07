# Paperless-ngx
**Teedy** es un software de código abierto para la gestión de documentos (Document Management System, DMS). Está diseñado para ayudar a las organizaciones y a los usuarios a digitalizar, organizar y gestionar de manera eficiente sus documentos y archivos electrónicos. Es ideal para pequeñas y medianas empresas, así como para usuarios que buscan una solución ligera y eficiente para la gestión documental, sin los costos asociados al software comercial.
Además, Teedy puede ejecutarse en entornos de contenedores Docker, lo que facilita su implementación y gestión. Para desplegar Teedy en Docker, se puede utilizar el script `rm_inst_dkr.sh`, que configura automáticamente los servicios necesarios y los ejecuta con Docker Compose. Este enfoque permite una instalación rápida y una configuración sencilla, proporcionando un entorno consistente y fácil de mantener.
![](./captura-paperless-ngx.png)

## Referencia
![Paperless-ngx - Docker Hub](https://hub.docker.com/r/linuxserver/paperless-ngx)

## rm_inst_dkr.sh:
Este script automatiza la configuración y el despliegue de Teedy junto con una base de datos PostgreSQL en contenedores Docker, creando un entorno de red seguro y persistente para los datos de la aplicación y la base de datos.

```shell
# rm_inst_dkr = 2.1

# [Paperless-ngx - GitHub](https://github.com/paperless-ngx/paperless-ngx)

DK_NOM="paperless-ngx" # ${DK_NOM}
DK_PRT="8010" # ${DK_PRT}

DK_DIR="/docker/$DK_NOM"
DK_CMP="$DK_DIR/docker-compose.yml"

sudo mkdir -p "$DK_DIR" && cat <<-EOF | sudo tee "$DK_CMP" > /dev/null

---
version: "2.1"
services:
  ${DK_NOM}:
    image: lscr.io/linuxserver/paperless-ngx:latest
    container_name: ${DK_NOM}
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=America/Argentina/La_Rioja
      - REDIS_URL= #optional
    volumes:
      - /path/to/appdata/config:/config
      - /path/to/appdata/data:/data
    ports:
      - ${DK_PRT}:8000
    restart: unless-stopped

    
EOF

sudo docker-compose -f "$DK_CMP" up -d
```
