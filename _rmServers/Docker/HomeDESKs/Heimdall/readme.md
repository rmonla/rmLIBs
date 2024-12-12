# <img src="./logo-Heimdall.svg" alt="Heimdall Logo" width="100"/> Heimdall

**Heimdall** es un dashboard para todas sus aplicaciones web. Sin embargo, no tiene que limitarse a las aplicaciones, puede añadir enlaces a lo que quiera. No hay iframes aquí, no hay aplicaciones dentro de aplicaciones, ni abstracción de APIs. Si crees que algo debería funcionar de cierta manera, 

- 📚 Más información:
  -  [Heimdall Application Dashboard](https://heimdall.site/)
- 🎥 Videos recomendados:
  - [**How to Set Up Heimdall in Docker**](https://youtu.be/A6vcTIzp_Ww?si=j4d0gjg9yrzVLnv5) - por [**TechHut**](https://www.youtube.com/@TechHut)

---

### Características destacadas
- **Interfaz moderna:** Diseño atractivo y minimalista con gráficos en tiempo real.
- **Altamente personalizable:** Configura widgets para mostrar la información que más necesitas.
- **Compatibilidad:** Funciona en múltiples plataformas y entornos gracias a Docker.
- **Temperaturas de CPU:** Permite habilitar lecturas de temperatura para un monitoreo más detallado.
- **Configuración sencilla:** Despliegue rápido mediante contenedores Docker.

---

## Script `rmDkrInstall_Heimdall.sh`
Este script automatiza la configuración y el despliegue de Heimdall utilizando contenedores Docker.

```bash
#!/bin/bash
# Script para configurar y desplegar Heimdall en Docker

# Variables de configuración
dkr_NOM="heimdall"                        # Nombre del contenedor
dkr_POR=80                                # Puerto del contenedor
dkr_TMZ="America/Argentina/La_Rioja"      # Zona horaria

# Configuración del archivo docker-compose
dkr_CFG=$(cat <<-EOF

services:
    ${dkr_NOM}:
        container_name: ${dkr_NOM}
        volumes:
            - ./config:/config
        environment:
            - PGID=1000
            - PUID=1000
            - TZ=${dkr_TMZ}
        ports:
            - ${dkr_POR}:80
            - 8443:443
        restart: unless-stopped
        image: linuxserver/heimdall

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
echo "Se ha desplegado correctamente en http://localhost:${dkr_POR}"

# tee rmDkrInstall_Heimdall.sh <<'SHELL'
# SHELL
# chmod +x rmDkrInstall_Heimdall.sh && ./rmDkrInstall_Heimdall.sh
