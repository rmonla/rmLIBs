# Como instalar Odoo en Debian 11.
## Fuente: [How To Install Odoo 15 on Ubuntu 20.04|18.04](https://computingforgeeks.com/how-to-install-odoo-on-ubuntu-linux/)

* Actu sistema

```bash
sudo apt update && sudo apt -y full-upgrade && [ -f /var/run/reboot-required ] && sudo reboot -f

```




* Install PostgreSQL Database (https://computingforgeeks.com/how-to-install-postgresql-13-on-ubuntu/)
-- Add PostgreSQL 13 repository to Ubuntu 22.04|20.04|18.04

sudo apt install -y curl gpg gnupg2 software-properties-common apt-transport-https lsb-release ca-certificates

curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc|sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg

echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" |sudo tee  /etc/apt/sources.list.d/pgdg.list


Actu sistema
--> Idem anterior

sudo apt install -y postgresql postgresql-client

* Install wkhtmltopdf (https://computingforgeeks.com/install-wkhtmltopdf-on-ubuntu-debian-linux/)

wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-2/wkhtmltox_0.12.6.1-2.bullseye_amd64.deb && sudo apt install -f -y ./wkhtmltox_0.12.6.1-2.bullseye_amd64.deb

* Step 4: Install Odoo

-- Descargar la ultima version de odoo (https://nightly.odoo.com/)

wget https://nightly.odoo.com/16.0/nightly/deb/odoo_16.0.latest_all.deb && sudo apt install -y -f ./odoo_16.0.latest_all.deb

* Verifico funcionamiento de odoo

--Estado del servicio

systemctl status odoo

--> ● odoo.service - Odoo Open Source ERP and CRM
Loaded: loaded (/lib/systemd/system/odoo.service; enabled; vendor preset: enabled)
Active: active (running) ...

-- Seteo para que inicie odoo al booteo.

sudo systemctl enable --now odoo

-- Verifico si esta configurado con el puerto 8069

ss -tunelp | grep 8069
--> tcp   LISTEN  0       128                  0.0.0.0:8069           0.0.0.0:*      uid:113 ino:1906251 sk:d <-> 

* Step 5: Configure Nginx Proxy for Odoo

--Instalacion --> sudo apt -y install nginx
--Configuracion --> sudo nano /etc/nginx/conf.d/odoo.conf


# Odoo Upstreams
upstream odooserver {
 server 127.0.0.1:8069;
}

server {
    listen 80;
    server_name gestor-erp.frlr.utn.edu.ar;
    access_log /var/log/nginx/odoo_access.log;
    error_log /var/log/nginx/odoo_error.log;


    # Proxy settings
    proxy_read_timeout 720s;
    proxy_connect_timeout 720s;
    proxy_send_timeout 720s;
    proxy_set_header X-Forwarded-Host $host;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header X-Real-IP $remote_addr;

    # Request for root domain
    location / {
       proxy_redirect off;
       proxy_pass http://odooserver;
    }

    # Cache static files
    location ~* /web/static/ {
        proxy_cache_valid 200 90m;
        proxy_buffering on;
        expires 864000;
        proxy_pass http://odooserver;
    }

    # Gzip
    gzip_types text/css text/less text/plain text/xml application/xml application/json application/javascript;
    gzip on;
}

-- Chequeo configuracion nginx --> sudo nginx  -t
-- Reinicio nginx --> sudo systemctl restart nginx
-- Chequeo estado del servicio nginx --> systemctl status nginx


*** Para instalar el certificado SSL hay que primero regitrar en el DNS gestor-erp.frlr.utn.edu.ar

* Encrypt SSL Certificate for Odoo on Nginx 

#Certbot installation

-- Actu sistema --> sudo apt update && sudo apt -y full-upgrade && [ -f /var/run/reboot-required ] && sudo reboot -f
-- Instala los módulos requeridos --> sudo apt install -y certbot && sudo apt install -y python-certbot-nginx

#Configure Nginx with Let's Encrypt SSL

-- Paro el servicio nginx --> sudo systemctl stop nginx

export DOMAIN="gestor-erp.frlr.utn.edu.ar"
export EMAIL="rmonla@frlr.utn.edu.ar"
sudo certbot certonly --standalone -d ${DOMAIN} --preferred-challenges http --agree-tos -n -m ${EMAIL} --keep-until-expiring























* Inicio instalacion por web

http://10.0.10.16:8069

Master Password:
$odooUTNlr00

Database Name:
utnlrodoo

Email:
rmonla@frlr.utn.edu.ar

Language:
Spanish (AR) / Español (AR)
Country

Argentina
Demo data



