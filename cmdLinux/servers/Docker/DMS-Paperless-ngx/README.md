# Paperless-ngx
**Teedy** es un software de código abierto para la gestión de documentos (Document Management System, DMS). Está diseñado para ayudar a las organizaciones y a los usuarios a digitalizar, organizar y gestionar de manera eficiente sus documentos y archivos electrónicos. Es ideal para pequeñas y medianas empresas, así como para usuarios que buscan una solución ligera y eficiente para la gestión documental, sin los costos asociados al software comercial.
Además, Teedy puede ejecutarse en entornos de contenedores Docker, lo que facilita su implementación y gestión. Para desplegar Teedy en Docker, se puede utilizar el script `rm_inst_dkr.sh`, que configura automáticamente los servicios necesarios y los ejecuta con Docker Compose. Este enfoque permite una instalación rápida y una configuración sencilla, proporcionando un entorno consistente y fácil de mantener.
![](./captura-paperless-ngx.png)

## Referencia
![Paperless-ngx - GitHub](https://github.com/paperless-ngx/paperless-ngx)

## rm_inst_dkr.sh:
Este script automatiza la configuración y el despliegue de Teedy junto con una base de datos PostgreSQL en contenedores Docker, creando un entorno de red seguro y persistente para los datos de la aplicación y la base de datos.

```bash
# rm_inst_dkr = 1.1

# [Paperless-ngx - GitHub](https://github.com/paperless-ngx/paperless-ngx)

DK_NOM="paperless-ngx"
DK_PRT="8010"
# ${DK_PRT}

DK_DIR="/docker/$DK_NOM"
DK_CMP="$DK_DIR/docker-compose.yml"

sudo mkdir -p "$DK_DIR" && cat <<-EOF | sudo tee "$DK_CMP" > /dev/null

# Docker Compose file for running paperless from the Docker Hub.
# This file contains everything paperless needs to run.
# Paperless supports amd64, arm and arm64 hardware.
#
# All compose files of paperless configure paperless in the following way:
#
# - Paperless is (re)started on system boot, if it was running before shutdown.
# - Docker volumes for storing data are managed by Docker.
# - Folders for importing and exporting files are created in the same directory
#   as this file and mounted to the correct folders inside the container.
# - Paperless listens on port 8010.
#
# In addition to that, this Docker Compose file adds the following optional
# configurations:
#
# - Instead of SQLite (default), PostgreSQL is used as the database server.
#
# To install and update paperless with this file, do the following:
#
# - Open portainer Stacks list and click 'Add stack'
# - Paste the contents of this file and assign a name, e.g. 'paperless'
# - Click 'Deploy the stack' and wait for it to be deployed
# - Open the list of containers, select paperless_webserver_1
# - Click 'Console' and then 'Connect' to open the command line inside the container
# - Run 'python3 manage.py createsuperuser' to create a user
# - Exit the console
#
# For more extensive installation and update instructions, refer to the
# documentation.

services:
  broker:
    image: docker.io/library/redis:7
    restart: unless-stopped
    volumes:
      - redisdata:/data

  db:
    image: docker.io/library/postgres:16
    restart: unless-stopped
    volumes:
      - pgdata:/var/lib/postgresql/data
    environment:
      POSTGRES_DB: paperless
      POSTGRES_USER: paperless
      POSTGRES_PASSWORD: paperless

  webserver:
    image: ghcr.io/paperless-ngx/paperless-ngx:latest
    restart: unless-stopped
    depends_on:
      - db
      - broker
    ports:
      - "${DK_PRT}:8000"
    volumes:
      - data:/usr/src/paperless/data
      - media:/usr/src/paperless/media
      - ./export:/usr/src/paperless/export
      - ./consume:/usr/src/paperless/consume
    environment:
      PAPERLESS_REDIS: redis://broker:6379
      PAPERLESS_DBHOST: db
# The UID and GID of the user used to run paperless in the container. Set this
# to your UID and GID on the host so that you have write access to the
# consumption directory.
      USERMAP_UID: 1000
      USERMAP_GID: 100
# Additional languages to install for text recognition, separated by a
# whitespace. Note that this is
# different from PAPERLESS_OCR_LANGUAGE (default=eng), which defines the
# language used for OCR.
# The container installs English, German, Italian, Spanish and French by
# default.
# See https://packages.debian.org/search?keywords=tesseract-ocr-&searchon=names&suite=buster
# for available languages.
      #PAPERLESS_OCR_LANGUAGES: tur ces
# Adjust this key if you plan to make paperless available publicly. It should
# be a very long sequence of random characters. You don't need to remember it.
      #PAPERLESS_SECRET_KEY: change-me
# Use this variable to set a timezone for the Paperless Docker containers. If not specified, defaults to UTC.
      #PAPERLESS_TIME_ZONE: America/Los_Angeles
# The default language to use for OCR. Set this to the language most of your
# documents are written in.
      #PAPERLESS_OCR_LANGUAGE: eng

volumes:
  data:
  media:
  pgdata:
  redisdata:
    
EOF

sudo docker-compose -f "$DK_CMP" up -d
```
