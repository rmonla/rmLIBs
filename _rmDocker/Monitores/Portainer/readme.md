# <img src="https://www.portainer.io/hubfs/portainer-logo-white-1.svg" alt="Portainer Logo" width="50%"/>

Este documento describe cómo configurar e implementar **Portainer** utilizando contenedores Docker. Portainer es una solución moderna y potente para la gestión de entornos Docker y Kubernetes, diseñada para simplificar la administración de contenedores, aplicaciones y redes, tanto en configuraciones domésticas como empresariales. Con una interfaz gráfica intuitiva y personalizable, Portainer centraliza las operaciones, aumentando la eficiencia y reduciendo la complejidad técnica.

---

## Enlaces de Consulta

- 📚 Información del Aplicativo:
  - [Sitio Oficial de Portainer](https://www.portainer.io/)
  - [Repositorio en GitHub](https://github.com/portainer/portainer)
  - [Documentación Oficial](https://docs.portainer.io/)
- 🎥 Videos Recomendados:
  - [NUEVA interfaz WEB para tus contenedores! - PORTAINER! / V2M](https://youtu.be/TSot5AnS-mk) - por [**Pelado Nerd**](https://www.youtube.com/@PeladoNerd)

---

## Características Destacadas

- **Gestión Centralizada:** Consolida todas las operaciones relacionadas con Docker y Kubernetes en una única plataforma, permitiendo el control completo de contenedores, redes y volúmenes.
- **Interfaz Moderna e Intuitiva:** Optimizada para navegadores y dispositivos móviles, con soporte para temas claros y oscuros.
- **Despliegue Rápido:** Instalación simplificada utilizando Docker Compose, con soporte multiplataforma en Linux, macOS y Windows.
- **Seguridad Avanzada:** Soporte para control de acceso basado en roles, autenticación multiusuario y auditorías.
- **Soporte para Kubernetes:** Permite gestionar clústeres de Kubernetes de manera eficiente junto con entornos Docker.
- **Integración con Stacks:** Posibilidad de desplegar aplicaciones en stacks mediante plantillas personalizadas.
- **Escalabilidad y Monitoreo:** Ideal para gestionar desde implementaciones locales hasta infraestructuras empresariales en la nube.

---

## Requisitos Previos

1. **Sistema Base:** 
   - Docker y Docker Compose deben estar instalados y configurados.
2. **Espacio de Almacenamiento:**
   - Suficiente para los datos persistentes de Portainer.
3. **Acceso a Puertos:**
   - Configuración del puerto 9000 para la interfaz web de Portainer.
4. **Privilegios Administrativos:**
   - Acceso root o permisos equivalentes para ejecutar Docker.

---

## Configuración e Implementación

### 1. Crear y Editar el Script de Despliegue

Crea un archivo de script llamado `rmDkr-Deploy-Portainer.sh` ejecutando:

```bash
nano rmDkr-Deploy-Portainer.sh
```

Copia y pega el siguiente contenido en el archivo:

```bash
#!/bin/bash
# Script para configurar e implementar Portainer en Docker
# Ricardo MONLA (https://github.com/rmonla)
# rmDocker|Portainer - Versión: 241230-0059

# Definición de Variables
dkrVRS=$(cat <<YAML
dkrNOM=portainer
dkrPOR=9000
dkrArchENV=.env
dkrArchYML=docker-compose.yml
appDirDAT=portainer-data
YAML
)

# Configuración del archivo docker-compose.yml
dkrYML=$(cat <<YAML
services:
  portainer:
    image: portainer/portainer-ce:latest
    container_name: \${dkrNOM}
    restart: unless-stopped
    security_opt:
      - no-new-privileges:true
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - ./\${appDirDAT}:/data
    ports:
      - \${dkrPOR}:9000
YAML
)

# Procesar y exportar variables
eval "$(echo "$dkrVRS" | grep -E '^[a-zA-Z_][a-zA-Z0-9_]*=' | sed 's/^/export /')"

# Crear directorios requeridos
crear_directorio() {
    echo "Creando el directorio $1"
    mkdir -p "$1" || { echo "Error al crear el directorio $1"; exit 1; }
}
dirDKR="$(pwd)/$dkrNOM"
crear_directorio "$dirDKR"
crear_directorio "$dirDKR/$appDirDAT"

# Crear archivos de configuración
escribir_archivo() {
    echo "Creando el archivo $2"
    echo "$1" > "$2" || { echo "Error al escribir $2"; exit 1; }
}
escribir_archivo "${dkrVRS}" "$dirDKR/$dkrArchENV"
escribir_archivo "${dkrYML}" "$dirDKR/$dkrArchYML"

# Desplegar el contenedor
archDkrComp="$dirDKR/$dkrArchYML"
echo "Iniciando el contenedor con docker-compose..."
docker compose -f "$archDkrComp" up -d || { echo "Error al ejecutar docker-compose"; exit 1; }

# Mensaje de finalización
echo "${dkrNOM} se ha desplegado correctamente en http://0.0.0.0:${dkrPOR}/"
```

---

### 2. Ejecutar el Script de Despliegue

Guarda el archivo y asegúrate de que tenga permisos de ejecución:

```bash
chmod +x rmDkr-Deploy-Portainer.sh
sh rmDkr-Deploy-Portainer.sh
```

---

## Notas Adicionales

- **Detener el Contenedor:**
  Para detener y eliminar el contenedor ejecuta:

  ```bash
  docker compose down
  ```

- **Actualizar Portainer:**
  Para actualizar a la última versión, utiliza:

  ```bash
  docker compose pull && docker compose up -d
  ```

- **Personalización Avanzada:**
  Revisa la [documentación oficial](https://docs.portainer.io/) para opciones avanzadas de configuración y seguridad.

---

## Créditos

**Ricardo MONLA**  
[GitHub](https://github.com/rmonla) | **rmDocker|Portainer - Versión: 241230-0059**
```