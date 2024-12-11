# Cómo instalar Odoo 16 en Debian 11
## Fuente: [How To Install Odoo 15 on Ubuntu 20.04|18.04](https://computingforgeeks.com/how-to-install-odoo-on-ubuntu-linux/)

1. Actualización del sistema

```bash
sudo apt update -y && sudo apt full-upgrade  -y && [ -f /var/run/reboot-required ] && sudo reboot -f
```

2. Instalar PostgreSQL Database ([Cómo instalar PostgreSQL 13 en Ubuntu](https://computingforgeeks.com/how-to-install-postgresql-13-on-ubuntu/))

   - Agregar el repositorio de PostgreSQL 13 a Ubuntu 22.04|20.04|18.04

   ```bash
   sudo apt install -y curl gpg gnupg2 software-properties-common apt-transport-https lsb-release ca-certificates
   curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg
   echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
   ```

   - Actualizar el sistema
   (El mismo código anterior)

   - Instalar los módulos de PostgreSQL

    ```bash
    sudo apt install -y postgresql postgresql-client
    ```

4. Descargar e instalar wkhtmltopdf (https://computingforgeeks.com/install-wkhtmltopdf-on-ubuntu-debian-linux/)

   ```
   wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-2/wkhtmltox_0.12.6.1-2.bullseye_amd64.deb && sudo apt install -f -y ./wkhtmltox_0.12.6.1-2.bullseye_amd64.deb
   ```

5. Descargar e instalar la última versión de Odoo (https://nightly.odoo.com/)

   ```
   wget https://nightly.odoo.com/16.0/nightly/deb/odoo_16.0.latest_all.deb && sudo apt install -y -f ./odoo_16.0.latest_all.deb
   ```

   - Verificar el funcionamiento del servicio de Odoo

   ```
   systemctl status odoo
   ```

   Resultado:
   ● odoo.service - Odoo ERP y CRM de código abierto
     Loaded: loaded (/lib/systemd/system/odoo.service; enabled; vendor preset: enabled)
     Active: active (running) ...

   - Configurar Odoo para iniciar automáticamente al arranque

   ```
   sudo systemctl enable --now odoo
   ```

   - Verificar si está configurado para usar el puerto 8069

   ```
   ss -tunelp | grep 8069
   ```

   Resultado:
   tcp   LISTEN  0       128                  0.0.0.0:8069           0.0.0.0:*      uid:113 ino:1906251 sk:d <->

6. Iniciar instalación por web

   Accede a:                     http://10.0.10.16:8069

   Contraseña Maestra:           $odooUTNlr00

   Nombre de la Base de Datos:   utnlrodoo

   Email:                        rmonla@frlr.utn.edu.ar

   Idioma:                       Español (AR)

   País:                         Argentina

   Datos de demostración:        Activados


# Comandos combinados.

```bash
start_time=$(date +%s) && \
sudo apt update && \
sudo apt -y full-upgrade && \
sudo apt install -y curl gpg gnupg2 software-properties-common apt-transport-https lsb-release ca-certificates && \
curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg && \
echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list && \
sudo apt update && \
sudo apt -y full-upgrade && \
sudo apt install -y postgresql postgresql-client && \
wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-2/wkhtmltox_0.12.6.1-2.bullseye_amd64.deb && \
sudo apt install -f -y ./wkhtmltox_0.12.6.1-2.bullseye_amd64.deb && \
wget https://nightly.odoo.com/16.0/nightly/deb/odoo_16.0.latest_all.deb && \
sudo apt install -f -y ./odoo_16.0.latest_all.deb && \
sudo systemctl enable --now odoo && \
end_time=$(date +%s) && \
duration=$((end_time-start_time)) && \
hours=$((duration / 3600)) && \
minutes=$(( (duration % 3600) / 60 )) && \
seconds=$((duration % 60)) && \
echo "Tiempo total de ejecución: $hours horas, $minutes minutos, $seconds segundos"

```



7. Configurar el Proxy Nginx para Odoo
   - Continuar con el tutorial del enlace de la fuente.

8. Instalar el certificado SSL
   - Continuar con el tutorial del enlace de la fuente.
   - Para instalar el certificado SSL, primero es necesario registrar en el DNS gestor-erp.frlr.utn.edu.ar.
