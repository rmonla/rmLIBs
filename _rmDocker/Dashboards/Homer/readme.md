# <img src="./logo-Homer.png" alt="Homer Logo" width="100"/> Homer

**Homer** es un dashboard para todas sus aplicaciones web. Sin embargo, no tiene que limitarse a las aplicaciones, puede añadir enlaces a lo que quiera. No hay iframes aquí, no hay aplicaciones dentro de aplicaciones, ni abstracción de APIs. Si crees que algo debería funcionar de cierta manera, 

- 📚 Más información:
  -  [Homer Documentation](https://github.com/bastienwirtz/homer)
- 📚 Más información:
  -  [Demo dashboard | Homer](https://homer-demo.netlify.app/)  
- 🎥 Videos recomendados:
  - [(3) Descubre 20 aplicaciones que puedes instalar con DOCKER... ¡te encantarán! - YouTube](https://www.youtube.com/watch?v=gqpJ7RE02Ao) - por [**Un loco y su tecnología**](https://www.youtube.com/@unlocoysutecnologia)

---

### Características destacadas
- **Interfaz moderna:** Diseño atractivo y minimalista con gráficos en tiempo real.
- **Altamente personalizable:** Configura widgets para mostrar la información que más necesitas.
- **Compatibilidad:** Funciona en múltiples plataformas y entornos gracias a Docker.
- **Temperaturas de CPU:** Permite habilitar lecturas de temperatura para un monitoreo más detallado.
- **Configuración sencilla:** Despliegue rápido mediante contenedores Docker.

---

## Script `rmDkrInstall_Homer.sh`
Este script automatiza la configuración y el despliegue de Homer utilizando contenedores Docker.

```bash
#!/bin/bash

# Script para configurar y desplegar Homer en Docker
# Versión: 241212-0835

# Variables de configuración
dkr_NOM="homer"                        # Nombre del contenedor
dkr_POR=7081                           # Puerto del contenedor
dkr_TMZ="America/Argentina/La_Rioja"   # Zona horaria
dir_CFG="config"                       # Directorio de configuración interna del contenedor

# Configuración del archivo docker-compose
dkr_CFG=$(cat <<-EOF
version: '3.8'

services:
  ${dkr_NOM}:
    image: b4bz/homer
    container_name: ${dkr_NOM}
    volumes:
      - ./${dir_CFG}:/www/assets # Asegúrate de que tu directorio de configuración local exista
    ports:
      - ${dkr_POR}:8080
    user: 1000:1000 # Por defecto
    environment:
      - INIT_ASSETS=1 # Requiere que el directorio de configuración sea escribible para el usuario del contenedor
      - TZ=${dkr_TMZ} # Configuración de zona horaria
    restart: unless-stopped
EOF
)

# Crear directorio y archivo docker-compose con la configuración
dkr_DIR="/docker/$dkr_NOM"
sudo mkdir -p "$dkr_DIR"

dkr_YML="$dkr_DIR/docker-compose.yml"
echo "$dkr_CFG" | sudo tee "$dkr_YML" > /dev/null

# Configuración necesaria para Homer
dir_CFG="$dkr_DIR/$dir_CFG"
if [ ! -d "$dir_CFG" ]; then
    sudo mkdir -p "$dir_CFG"
    sudo chmod -R 777 "$dir_CFG"
fi

# Ejecutar docker-compose
sudo docker-compose -f "$dkr_YML" up -d || {
    echo "Error al iniciar los servicios con docker-compose. Verifica los logs para más detalles."
    exit 1
}

# Mensaje de finalización
echo "Se ha desplegado correctamente en http://localhost:${dkr_POR}"



# tee rmDkrInstall_Homer.sh <<'SHELL'
# SHELL
# chmod +x rmDkrInstall_Homer.sh && ./rmDkrInstall_Homer.sh
