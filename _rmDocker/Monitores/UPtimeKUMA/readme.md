# <img src="https://www.php.net/images/logos/php-logo-white.svg" alt="PHP Logo" width="100"/> Uptime Kuma

Este documento describe la configuración de un contenedor genérico para preparar un entorno de desarrollo de sitios PHP utilizando Docker. La configuración incluye un servidor Apache con PHP 8.2, accesible a través de un puerto especificado y configurado mediante un archivo `.env`.

## Requisitos Previos

- Docker y Docker Compose instalados en el sistema.
- Directorio con el código fuente del sitio PHP preparado.

---

### Más Información

- 📚 [Documentación Oficial de Uptime Kuma](https://www.php.net/docs.php)

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
dkrNOM=php_dev_site                         # Nombre del contenedor
dkrPOR=8080                                 # Puerto del contenedor
dkrTMZ="America/Argentina/La_Rioja"        # Zona horaria

# Variables del Sitio
dkrSRC=./                                   # Ruta del código fuente
```

- **`dkrNOM`**: Define el nombre del contenedor.
- **`dkrPOR`**: Especifica el puerto en el que el contenedor estará disponible.
- **`dkrTMZ`**: Configura la zona horaria dentro del contenedor.
- **`dkrSRC`**: Ruta local al directorio que contiene los archivos del sitio PHP.

---

### 2. **Archivo `docker-compose.yml`**

El archivo `docker-compose.yml` define el servicio Docker para el entorno PHP.

```yaml
version: '3.8'
services:
  php-apache:
    image: php:8.2-apache
    container_name: ${dkrNOM}
    ports:
      - "${dkrPOR}:80"
    volumes:
      - ${dkrSRC}:/var/www/html
    environment:
      - TZ=${dkrTMZ}
    restart: always
```

#### Descripción de los componentes:

- **`image`**: Utiliza la imagen oficial de PHP con Apache para ejecutar el sitio.
- **`container_name`**: Asigna un nombre al contenedor.
- **`ports`**: Redirige el puerto especificado en el archivo `.env` al puerto 80 del contenedor.
- **`volumes`**: Monta el código fuente en el directorio web del contenedor.
- **`environment`**: Configura la zona horaria usando la variable definida en el archivo `.env`.
- **`restart`**: Garantiza que el contenedor se reinicie automáticamente en caso de fallos.

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

- **Personalización:**
  Puedes ajustar el archivo `docker-compose.yml` para incluir extensiones adicionales de PHP según sea necesario para tu proyecto.

