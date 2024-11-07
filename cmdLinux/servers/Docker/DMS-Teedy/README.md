# Teedy
![](./captura-teedy.png)

## Referencia
![teedy DMS - GitHub](https://github.com/sismics/docs)

## Descripción:
**Teedy** es un software de código abierto para la gestión de documentos (Document Management System, DMS). Está diseñado para ayudar a las organizaciones y a los usuarios a digitalizar, organizar y gestionar de manera eficiente sus documentos y archivos electrónicos. Es ideal para pequeñas y medianas empresas, así como para usuarios que buscan una solución ligera y eficiente para la gestión documental, sin los costos asociados al software comercial.

Además, Teedy puede ejecutarse en entornos de contenedores Docker, lo que facilita su implementación y gestión. Para desplegar Teedy en Docker, se puede utilizar el script `rm_inst_dkr.sh`, que configura automáticamente los servicios necesarios y los ejecuta con Docker Compose. Este enfoque permite una instalación rápida y una configuración sencilla, proporcionando un entorno consistente y fácil de mantener.

## rm_inst_dkr.sh:
Este script automatiza la configuración y el despliegue de Teedy junto con una base de datos PostgreSQL en contenedores Docker, creando un entorno de red seguro y persistente para los datos de la aplicación y la base de datos.

```bash
# rm_inst_dkr= 1.2

# [teedy DMS - GitHub]!(https://github.com/sismics/docs)
# ${DK_PRT}

DK_NOM="teedydocs"
DK_PRT="8080"

DK_DIR="/docker/$DK_NOM"
DK_CMP="$DK_DIR/docker-compose.yml"

sudo mkdir -p "$DK_DIR" && cat <<-EOF | sudo tee "$DK_CMP" > /dev/null

version: '3'
services:
# Teedy Application
  teedy-server:
    image: sismics/docs:v1.11
    restart: unless-stopped
    ports:
      # Map internal port to host
      - ${DK_PRT}:8080
    environment:
      # Base url to be used
      DOCS_BASE_URL: "https://docs.example.com"
      # Set the admin email
      DOCS_ADMIN_EMAIL_INIT: "admin@example.com"
      # Set the admin password (in this example: "superSecure")
      DOCS_ADMIN_PASSWORD_INIT: "$$2a$$05$$PcMNUbJvsk7QHFSfEIDaIOjk1VI9/E7IPjTKx.jkjPxkx2EOKSoPS"
      # Setup the database connection. "teedy-db" is the hostname
      # and "teedy" is the name of the database the application
      # will connect to.
      DATABASE_URL: "jdbc:postgresql://teedy-db:5432/teedy"
      DATABASE_USER: "teedy_db_user"
      DATABASE_PASSWORD: "teedy_db_password"
      DATABASE_POOL_SIZE: "10"
    volumes:
      - ./docs/data:/data
    networks:
      - docker-internal
      - internet
    depends_on:
      - teedy-db

# DB for Teedy
  teedy-db:
    image: postgres:13.1-alpine
    restart: unless-stopped
    expose:
      - 5432
    environment:
      POSTGRES_USER: "teedy_db_user"
      POSTGRES_PASSWORD: "teedy_db_password"
      POSTGRES_DB: "teedy"
    volumes:
      - ./docs/db:/var/lib/postgresql/data
    networks:
      - docker-internal

networks:
  # Network without internet access. The db does not need
  # access to the host network.
  docker-internal:
    driver: bridge
    internal: true
  internet:
    driver: bridge
    
EOF

sudo docker-compose -f "$DK_CMP" up -d
