# <img src="./logo-Dashdot.png" alt="Dashdot Logo" width="100"/> DashDOT

**Dashdot** es un panel de control moderno y altamente personalizable diseñado para monitorear el estado de tu servidor. Proporciona información clara y visualmente atractiva sobre recursos como CPU, RAM, almacenamiento y red, todo en tiempo real. Ideal para quienes buscan una solución sencilla y efectiva para supervisar su infraestructura.

- 📚 Más información:
  -  [Home | dash.](https://getdashdot.com/)
- 🎥 Videos recomendados:
  - [**How to Set Up DashDOT in Docker**](https://youtu.be/A6vcTIzp_Ww?si=j4d0gjg9yrzVLnv5) - por [**TechHut**](https://www.youtube.com/@TechHut)

---

### Características destacadas
- **Interfaz moderna:** Diseño atractivo y minimalista con gráficos en tiempo real.
- **Altamente personalizable:** Configura widgets para mostrar la información que más necesitas.
- **Compatibilidad:** Funciona en múltiples plataformas y entornos gracias a Docker.
- **Temperaturas de CPU:** Permite habilitar lecturas de temperatura para un monitoreo más detallado.
- **Configuración sencilla:** Despliegue rápido mediante contenedores Docker.

---

## Script `rmDkrInstall_Dashdot.sh`
Este script automatiza la configuración y el despliegue de DashDOT utilizando contenedores Docker.

```bash
#!/bin/bash
# Script para configurar y desplegar DashDOT en Docker

# Variables de configuración
dkr_NOM="dashdot"                           # Nombre del contenedor
dkr_POR=7512                                # Puerto del contenedor
dkr_TMZ="America/Argentina/La_Rioja"        # Zona horaria

# Configuración del archivo docker-compose
dkr_CFG=$(cat <<-EOF
version: '3.8'
services:
    ${dkr_NOM}:
        container_name: ${dkr_NOM}
        ports:
            - ${dkr_POR}:3001
        environment:
            - DASHDOT_ENABLE_CPU_TEMPS=true
            - DASHDOT_OVERRIDE_OS=DSM
        volumes:
            - /:/mnt/host:ro
        privileged: true
        restart: always
        image: mauricenino/dashdot
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
