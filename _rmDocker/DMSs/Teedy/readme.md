# Sismics Docs [Teedy] ![](./teedy_logo.png)  
![](./teedy_488755_full.png)

**Teedy** es un software de código abierto para la gestión de documentos (Document Management System, DMS). Está diseñado para ayudar a las organizaciones y a los usuarios a digitalizar, organizar y gestionar de manera eficiente sus documentos y archivos electrónicos. Es ideal para pequeñas y medianas empresas, así como para usuarios que buscan una solución ligera y eficiente para la gestión documental, sin los costos asociados al software comercial.

## rm_dkr_install:
Este script automatiza la configuración y el despliegue del sistema en contenedores Docker.

```shell
# rm_dkr_install_v-3.1

# ![teedy DMS - GitHub](https://github.com/sismics/docs)
# [Iniciar --> http://localhost:8080 admin:admin

DKR_NOM="teedydocs"     # ${DKR_NOM} Nombre del contenedor
DKR_POR="8080"          # ${DKR_POR} Puerto del contenedor

DKR_DIR="/docker/$DKR_NOM"
DKR_YML="$DKR_DIR/docker-compose.yml"

# Cadena con la configuración del archivo docker-compose
DKR_CFG=$(cat <<-EOF
---
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
---
EOF
)

# Crear directorio y archivo docker-compose con la configuración
sudo mkdir -p "$DKR_DIR" && echo "$DKR_CFG" | sudo tee "$DKR_YML" > /dev/null

# Ejecutar docker-compose
sudo docker-compose -f "$DKR_YML" up -d
```

# rm_dkr_clean

Este script automatiza la tarea de detener, eliminar un contenedor Docker y remover la imagen asociada. Es útil para mantener limpio el entorno Docker y liberar espacio en el sistema.

```shell
# rm_dkr_clean_v-2.2

DKR_NOM="teedydocs"

# Obtiene el ID del contenedor basado en el nombre o imagen
DKR_LID=$(sudo docker ps | grep $DKR_NOM | awk '{print $1}')

# Obtiene la imagen asociada al contenedor
DKR_IMG=$(sudo docker ps --filter "id=$DKR_LID" --format "{{.Image}}")

# Detiene, elimina el contenedor y elimina la imagen
sudo docker stop $DKR_LID
sudo docker rm $DKR_LID
sudo docker rmi $DKR_IMG
```

