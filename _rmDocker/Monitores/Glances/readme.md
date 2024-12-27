# <img src="https://nicolargo.github.io/glances/public/images/glances.png" alt="Glances Logo" width="100"/> Glances

Este documento describe cómo configurar un contenedor Docker para implementar **Glances**, una herramienta avanzada para monitorizar sistemas, aplicaciones y redes en tiempo real. Glances proporciona una visión completa y detallada del rendimiento del sistema con una interfaz personalizable y moderna.

---

### Enlaces de consulta:
- 📚 Información del Aplicativo:
  - [Sitio Oficial de Glances](https://nicolargo.github.io/glances/)
  - [Documentación](https://github.com/nicolargo/glances/wiki/)
  - [GitHub](https://github.com/nicolargo/glances)
- 🎥 Videos recomendados:
  - [Monitoreo con Glances en Linux - Tu htop con esteroides](https://youtu.be/oia6WqcOipU?si=Q5zA9J_Y4egr7KdD) - por [**Manuel Cabrera Caballero**](https://www.youtube.com/@DriveMeca)

---

### Características destacadas

- **Monitorización integral:** Supervisa métricas clave del sistema, como uso de CPU, memoria, discos, redes, y más.
- **Interfaz web accesible:** Ofrece un servidor web integrado para acceder a los datos desde cualquier navegador.
- **Fácil implementación:** Configuración rápida utilizando Docker y Docker Compose.
- **Personalización avanzada:** Compatible con múltiples opciones de configuración, soporte para plugins y extensiones.
- **Soporte multiplataforma:** Disponible para Linux, macOS, Windows y entornos en contenedores.
- **Escalabilidad:** Diseñado para monitorear desde sistemas individuales hasta infraestructuras complejas.

---

## Requisitos Previos

- Docker y Docker Compose instalados en el sistema.
- Espacio en disco suficiente para almacenar datos persistentes.
- Acceso al puerto definido para la interfaz web.

---

### 1. **Archivo `.env`**

El archivo `.env` contiene las variables de entorno necesarias para configurar el contenedor.

```bash
# Variables del Docker
dkrNOM=glances                       # Nombre del contenedor
dkrPOR=61208                         # Puerto del contenedor
dkrTMZ="America/Argentina/La_Rioja"  # Zona horaria
```

---

### 2. **Archivo `docker-compose.yml`**

El archivo `docker-compose.yml` define el servicio Docker para desplegar Glances.

```yaml
version: '3.8'
services:
  glances:
    container_name: ${dkrNOM}
    image: nicolargo/glances:latest
    environment:
      - TZ=${dkrTMZ}
      - GLANCES_OPT=-w
    ports:
      - ${dkrPOR}:61208
    restart: unless-stopped
```

---

### Pasos para Implementar

1. Crea un directorio para el proyecto y navega hasta él:

   ```bash
   mkdir glances_monitoring && cd glances_monitoring
   ```

2. Crea los archivos `.env` y `docker-compose.yml` en el directorio.
   
   ```bash
   nano .env
   ```
   
   ```bash
   nano docker-compose.yml
   ```

3. Inicia el contenedor:

   ```bash
   docker-compose up -d
   ```

4. Accede a la interfaz web de Glances en tu navegador utilizando la dirección:

   ```
   http://localhost:<dkrPOR>
   ```

   Reemplaza `<dkrPOR>` con el valor definido en el archivo `.env`.

---

### Notas Adicionales

- **Detener el Contenedor:**
  Para detener el contenedor, utiliza el comando:

  ```bash
  docker-compose down
  ```

- **Personalización:**
  Puedes agregar configuraciones avanzadas, como parámetros adicionales para `GLANCES_OPT` según tus necesidades específicas.

- **Persistencia:**
  Aunque esta configuración no utiliza volúmenes persistentes, puedes añadirlos si necesitas conservar datos entre reinicios.

- **Monitoreo remoto:**
  Configura Glances para permitir acceso remoto habilitando el soporte para direcciones IP específicas en la configuración.

