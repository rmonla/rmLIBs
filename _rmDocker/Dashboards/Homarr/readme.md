# <img src="./logo-homarr.png" alt="Homarr Logo" width="100"/> Homarr
**Homarr** es un tablero simple pero poderoso diseñado para facilitar la administración de servidores. Permite centralizar accesos a servicios y monitorear recursos de manera eficiente. Una de sus características clave es la posibilidad de configurar certificados gratuitos y automáticos para cualquier servidor, sin importar si utiliza Linux, Docker o Nginx, ya que se puede poner un proxy por delante para gestionar todo.

- 📚 Más información:
  - [Homarr documentation](https://homarr.dev/)
- 🎥 Videos recomendados:
  - [**my FAVORITE Home Server Dashboard - Homarr Setup in Docker**](https://youtu.be/A6vcTIzp_Ww?si=j4d0gjg9yrzVLnv5) - por [**TechHut**](https://www.youtube.com/@TechHut)

---

### Características destacadas
- **Facilidad de uso:** Configuración e integración simples.
- **Gestión eficiente:** Consolida accesos a servicios en un solo lugar.
- **Certificados automáticos:** Proxy integrado para gestionar certificados gratuitos.

---

## Iniciador:
Accede a Homarr en tu navegador a través de `localhost:7575`.

---

## Script `rm_dkr_install.sh`
Este script automatiza la configuración y el despliegue de Homarr utilizando contenedores Docker. A continuación, se detallan las instrucciones:

### Código del script:

```bash
#!/bin/bash
# Script para configurar y desplegar Homarr en Docker
# Versión: 241219-1637

# Variables de configuración
dkr_NOM="homarr"                            # Nombre del contenedor
dkr_POR=7575                                # Puerto del contenedor
dkr_TMZ="America/Argentina/La_Rioja"        # Zona horaria

# Configuración del archivo docker-compose
dkr_CFG=$(cat <<-EOF
version: '3'
#---------------------------------------------------------------------#
#     Homarr - A simple, yet powerful dashboard for your server.      #
#---------------------------------------------------------------------#
services:
  homarr:
    image: ghcr.io/ajnart/homarr:latest
    container_name: ${dkr_NOM}
    ports:
      - '${dkr_POR}:7575'
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock # Integración opcional con Docker
      - ./homarr/configs:/app/data/configs
      - ./homarr/icons:/app/public/icons
      - ./homarr/data:/data
    restart: unless-stopped
EOF
)

# Crear directorio y archivo docker-compose con la configuración
dkr_DIR="/docker/$dkr_NOM"
dkr_YML="$dkr_DIR/docker-compose.yml"

sudo mkdir -p "$dkr_DIR" 
echo "$dkr_CFG" | sudo tee "$dkr_YML" > /dev/null

# Ejecutar docker-compose
sudo docker-compose -f "$dkr_YML" up -d

# Mensaje de finalización
echo "Homarr se ha desplegado correctamente en http://localhost:${dkr_POR}"

# tee rmDkrInstall_Homarr.sh <<'SHELL'
# SHELL
# chmod +x rmDkrInstall_Homarr.sh && ./rmDkrInstall_Homer.sh
```
