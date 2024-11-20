# UNIFY
![](./paperless-ngx-banner.png)

**Paperless-ngx** es un sistema de gestión de documentos de código abierto diseñado para digitalizar, organizar y buscar documentos de forma eficiente. Permite a los usuarios escanear, almacenar y gestionar documentos electrónicos, proporcionando características como la indexación automática, el reconocimiento óptico de caracteres (OCR) y un sistema de búsqueda avanzado. Es ideal para individuos y organizaciones que buscan una solución accesible y personalizable para gestionar sus archivos digitales de manera ordenada y segura.

## rm_dkr_install:
Este script automatiza la configuración y el despliegue del sistema en contenedores Docker.

```shell
# rm_dkr_install 2.1

DK_NOM="unifi"
DK_PRT="8080"
DK_DIR="/docker/$DK_NOM"
DK_CMP="$DK_DIR/docker-compose.yml"

sudo mkdir -p "$DK_DIR" 

cat <<EOF | sudo tee "$DK_CMP" > /dev/null
version: '3'

services:
  unifi:
    image: ghcr.io/goofball222/unifi
    container_name: unifi
    restart: unless-stopped
    network_mode: bridge
    ports:
      - 3478:3478/udp
      - "$DK_PRT":8080
      - 8443:8443
      - 8880:8880
      - 8843:8843
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - ./cert:/usr/lib/unifi/cert
      - ./data:/usr/lib/unifi/data
      - ./logs:/usr/lib/unifi/logs
    environment:
      - TZ=America/Argentina/La_Rioja
EOF

sudo docker-compose -f "$DK_CMP" up -d
```
# rm_dkr_clean

Este script automatiza la tarea de detener, eliminar un contenedor Docker y remover la imagen asociada. Es útil para mantener limpio el entorno Docker y liberar espacio en el sistema.

```shell
# $DKR_NOM verificar si está cargado.

# Obtiene el ID del contenedor basado en el nombreTZ=America/Argentina/La_Rioja o imagen
DKR_LID=$(sudo docker ps | grep $DKR_NOM | awk '{print $1}')

# Obtiene la imagen asociada al contenedor
DKR_IMG=$(sudo docker ps --filter "id=$DKR_LID" --format "{{.Image}}")

# Detiene, elimina el contenedor y elimina la imagTZ=America/Argentina/La_Riojaen
sudo docker stop $DKR_LID
sudo docker rm $DKR_LID
sudo docker rmi $DKR_IMG
```

