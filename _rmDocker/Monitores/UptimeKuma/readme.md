# <img src="https://uptime.kuma.pet/img/icon.svg" alt="Uptime Kuma Logo" width="100"/> Uptime Kuma

Este documento describe la configuración de un contenedor genérico para preparar un entorno de desarrollo de sitios PHP utilizando Docker. La configuración incluye un servidor Apache con PHP 8.2, accesible a través de un puerto especificado y configurado mediante un archivo `.env`.

## Requisitos Previos

- Docker y Docker Compose instalados en el sistema.
- Directorio con el código fuente del sitio PHP preparado.

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

- **Facilidad de uso:** Esta configuración permite crear un entorno de desarrollo funcional en minutos. Solo se requiere un archivo `.env` para parametrizar las variables principales.
- **Compatibilidad:** Utiliza la imagen oficial de PHP con Apache, garantizando estabilidad y soporte continuo.
- **Flexibilidad:** La configuración es adaptable, permitiendo agregar extensiones o modificar el entorno según las necesidades del proyecto.
- **Persistencia:** Monta el directorio del proyecto local dentro del contenedor para mantener sincronizados los cambios.

---

### 1. **Archivo `.env`**

El archivo `.env` contiene las variables de entorno necesarias para configurar el contenedor.

```bash
# Variables del Docker
dkrNOM=uptime-kuma                         # Nombre del contenedor
dkrPOR=3001                                # Puerto del contenedor

```

---

### 2. **Archivo `docker-compose.yml`**

El archivo `docker-compose.yml` define el servicio Docker para el entorno PHP.

```yaml
services:
    ${dkrNOM}:
        container_name: ${dkrNOM}
        image: louislam/uptime-kuma:1
        restart: always
        ports:
            - ${dkrPOR}:3001
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
   mkdir php_dev && cd php_dev
   ```

2. Crea los archivos `.env` y `docker-compose.yml` en el directorio.

3. Asegúrate de que el código fuente del sitio PHP esté ubicado en el directorio especificado por `dkrSRC`.

4. Inicia el contenedor:

   ```bash
   docker-compose up -d
   ```

5. Accede al sitio en el navegador usando la dirección:

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
