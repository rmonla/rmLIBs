# <img src="https://uptime.kuma.pet/img/icon.svg" alt="Uptime Kuma Logo" width="100"/> Uptime Kuma

Este documento describe la configuración de un contenedor Docker para implementar **Uptime Kuma**, una herramienta de monitorización de sitios y servicios en tiempo real. Uptime Kuma es una solución autohospedada que permite supervisar el estado de servicios con un diseño moderno, intuitivo y altamente personalizable.

---

### Enlaces de consulta:
- 📚 Información del Aplicativo:
  - [Sitio Oficial de Uptime Kuma](https://uptime.kuma.pet/)
  - [Documentación](https://github.com/louislam/uptime-kuma/wiki)
  - [Demo](https://demo.kuma.pet/start-demo)
- 🎥 Videos recomendados:
  - [Uptime Kuma - Monitorización de dispositivos #Docker](https://www.youtube.com/watch?v=2dsOiz8Seoc) - por [**No Solo Hacking**](https://www.youtube.com/@NoSoloHacking)

---

### Características destacadas

- **Monitorización en tiempo real:** Supervisa sitios, servidores y servicios con notificaciones personalizables.
- **Fácil implementación:** Configuración sencilla utilizando Docker y Docker Compose.
- **Interfaz moderna:** Diseño intuitivo con soporte para múltiples tipos de monitoreo, como HTTP(S), TCP, Ping, y más.
- **Alta personalización:** Compatible con múltiples idiomas y adaptable a las necesidades del usuario.
- **Persistencia de datos:** La configuración y los datos de monitoreo se almacenan en volúmenes Docker, asegurando su conservación entre reinicios.

---

## Requisitos Previos

- Docker y Docker Compose instalados en el sistema.
- Espacio suficiente en disco para almacenar datos persistentes.

---

### 1. **Archivo `.env`**

El archivo `.env` contiene las variables de entorno necesarias para configurar el contenedor.

```bash
# Variables del Docker
dkrNOM=uptime-kuma                          # Nombre del contenedor
dkrPOR=3001                                 # Puerto del contenedor
```

---

### 2. **Archivo `docker-compose.yml`**

El archivo `docker-compose.yml` define el servicio Docker para desplegar Uptime Kuma.

```yaml
version: '3.8'
services:
  uptime-kuma:
    container_name: ${dkrNOM}
    image: louislam/uptime-kuma:1
    restart: always
    ports:
      - "${dkrPOR}:3001"
    volumes:
      - uptime-kuma:/app/data
volumes:
  uptime-kuma:
    external: true
    name: uptime-kuma
```

---

### Pasos para Implementar

1. Crea un directorio para el proyecto y navega hasta él:

   ```bash
   mkdir uptime_kuma && cd uptime_kuma
   ```

2. Crea los archivos `.env` y `docker-compose.yml` en el directorio.

3. Inicia el contenedor:

   ```bash
   docker-compose up -d
   ```

4. Accede a Uptime Kuma en el navegador utilizando la dirección:

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
  Puedes agregar configuraciones avanzadas o integraciones según tus necesidades, como notificaciones a través de Slack, Discord, correo electrónico, entre otros.

- **Persistencia:**
  Asegúrate de que el volumen Docker definido esté correctamente configurado para evitar la pérdida de datos entre reinicios.

