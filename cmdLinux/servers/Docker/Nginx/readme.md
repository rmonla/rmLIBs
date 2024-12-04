##  Certificados AUTOMÁTICOS y GRATIS para CUALQUIER SERVIDOR - Nginx Proxy Manager
### Pelado Nerd
Hoy vemos como poder darle certificados gratis y automáticos a cualquier servidor, no hace falta que corra linux, docker, o nginx. Ponemos un proxy adelante que maneja todo.
- ![ Video ](https://www.youtube.com/watch?v=0n9DLj2ndo4)
- ![ GitHUb ](https://github.com/pablokbs/peladonerd/tree/master/v2m/32)

### Iniciador:
- localhost:81 admin@example.com:changeme

### rm_dkr_install.sh
Este script automatiza la configuración y el despliegue del sistema en contenedores Docker.

```shell
# rm_dkr_install v-3.1

DKR_NOM="nginx-pm"
DKR_POR=81
DKR_TMZ="America/Argentina/La_Rioja"
# ${DKR_NOM} ${DKR_POR} ${DKR_TMZ}

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

# rm_dkr_clean

Este script automatiza la tarea de detener, eliminar un contenedor Docker y remover la imagen asociada. Es útil para mantener limpio el entorno Docker y liberar espacio en el sistema.

```shell
# rm_dkr_clean v-2.2 verificar

DKR_NOM="nginx-pm"

# Obtiene el ID del contenedor basado en el nombre o imagen
DKR_LID=$(sudo docker ps | grep $DKR_NOM | awk '{print $1}')

# Obtiene la imagen asociada al contenedor
DKR_IMG=$(sudo docker ps --filter "id=$DKR_LID" --format "{{.Image}}")

# Detiene, elimina el contenedor y elimina la imagen
sudo docker stop $DKR_LID
sudo docker rm $DKR_LID
sudo docker rmi $DKR_IMG
```
