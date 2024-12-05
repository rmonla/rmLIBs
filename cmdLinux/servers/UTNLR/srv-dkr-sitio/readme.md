### Configuración IP Debian
```shell
sudo nano /etc/network/interfaces
```

```shell
# Fuente de otros archivos de configuración de interfaces
source /etc/network/interfaces.d/*

# La interfaz de loopback (siempre debe estar configurada así)
auto lo
iface lo inet loopback

# Permitir que la interfaz se active automáticamente cuando se detecte
allow-hotplug ens18

# Configuración de la IP dinámica
# iface ens18 inet dhcp

# Configuración de la IP estática
iface ens18 inet static
    address 190.114.205.5
    netmask 255.255.255.0
    gateway 190.114.205.1
    dns-nameservers 8.8.8.8 8.8.4.4

```
### Instalación rm-dkr_install_nginx-mp
```shell
nano rm-dkr_install_nginx-mp.sh
```

```shell
# rm_dkr_install v-3.1

DKR_NOM="nginx-pm"
DKR_POR=81
DKR_TMZ="America/Argentina/La_Rioja"
# ${DKR_NOM} ${DKR_POR} ${DKR_TMZ}

DKR_DIR="/docker/$DKR_NOM"
DKR_YML="$DKR_DIR/docker-compose.yml"

DKR_CFG=$(cat <<-EOF
version: '3'
services:
  app:
    image: 'jc21/nginx-proxy-manager:latest'
    ports:
      - '80:80'
      - '${DKR_POR}:81'
      - '443:443'
    volumes:
      - ./config.json:/app/config/production.json
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
  db:
    image: 'jc21/mariadb-aria:10.4.15'
    environment:
      MYSQL_ROOT_PASSWORD: 'npm'
      MYSQL_DATABASE: 'npm'
      MYSQL_USER: 'npm'
      MYSQL_PASSWORD: 'npm'
    volumes:
      - ./data/mysql:/var/lib/mysql
EOF
)

# Crear directorio y archivo docker-compose con la configuración
sudo mkdir -p "$DKR_DIR" && echo "$DKR_CFG" | sudo tee "$DKR_YML" > /dev/null

# Ejecutar docker-compose
sudo docker-compose -f "$DKR_YML" up -d

```
### Administrador Web:
- http://190.114.205.5:81 rmonla@frlr.utn.edu.ar #...UTN
