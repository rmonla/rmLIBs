# Paperless-ngx
.
![](./captura-paperless-ngx.png)

## Referencia
![Paperless-ngx - Docker Hub](https://hub.docker.com/r/linuxserver/paperless-ngx)

## rm_inst_dkr.sh:
Este script automatiza la configuración y el despliegue en un contenedores Docker.

```shell
# rm_inst_dkr = 2.2

# [Paperless-ngx - Docker Hub](https://hub.docker.com/r/linuxserver/paperless-ngx)
# [Iniciar --> http://localhost:8010 admin:admin

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
