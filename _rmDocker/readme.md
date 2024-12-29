### Install Docker
- ![ Install Docker Engine on Debian ](https://docs.docker.com/engine/install/debian/)

```shell
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose docker-compose-plugin
```

### Install agente Portainer
```shell
docker run -d \
  -p 9001:9001 \
  --name portainer_agent \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /var/lib/docker/volumes:/var/lib/docker/volumes \
  -v /:/host \
  portainer/agent:2.21.4
```
### rmDkrClean.sh
```shell
# rmDkrClean.sh 
# Este script automatiza la tarea de detener, eliminar un contenedor Docker y remover la imagen asociada.
# Es útil para mantener limpio el entorno Docker y liberar espacio en el sistema.

# Verifica si se ha pasado un parámetro
if [ -z "$1" ]; then
    echo "Uso: $0 <nombre_del_contenedor_o_imagen>"
    exit 1
fi

DKR_NOM="$1"

# Obtiene el ID del contenedor basado en el nombre o imagen
DKR_LID=$(sudo docker ps | grep $DKR_NOM | awk '{print $1}')

# Verifica si se encontró el contenedor
if [ -z "$DKR_LID" ]; then
    echo "No se encontró un contenedor con el nombre o imagen: $DKR_NOM"
    exit 1
fi

# Obtiene la imagen asociada al contenedor
DKR_IMG=$(sudo docker ps --filter "id=$DKR_LID" --format "{{.Image}}")

# Detiene, elimina el contenedor y elimina la imagen
sudo docker stop $DKR_LID
sudo docker rm $DKR_LID
sudo docker rmi $DKR_IMG

echo "Contenedor $DKR_NOM eliminado junto con su imagen asociada."

```
### 🎥 Videos recomendados:
  - [**TechHut**](https://www.youtube.com/@TechHut)
    -  ☑️[my FAVORITE Home Server Dashboard - Homarr Setup in Docker](https://youtu.be/A6vcTIzp_Ww?si=j4d0gjg9yrzVLnv5)
    - [my NEW Proxmox Media Server - Full Walkthrough Guide Pt.2 (Jellyfin, Sonarr, Gluetun, and MORE)](https://www.youtube.com/watch?v=Uzqf0qlcQlo)
      
  - [**No Solo Hacking**](https://www.youtube.com/@NoSoloHacking)
    - [ DIETPI - #Sonarr + #PLEX + #Jellyfin + #Transmission + #Jackett - ACTUALIZADO ](https://www.youtube.com/watch?v=I93VHAlpRsY)
    - [Uptime Kuma - Monitorización de dispositivos #Docker](https://www.youtube.com/watch?v=2dsOiz8Seoc)
      
- [**nanoninja**](https://github.com/nanoninja)
    - [docker-nginx-php-mysql](https://github.com/nanoninja/docker-nginx-php-mysql)
      
- [**Un loco y su tecnología**](https://www.youtube.com/@unlocoysutecnologia)
    -  ☑️[Descubre 20 aplicaciones que puedes instalar con DOCKER... ¡te encantarán!](https://www.youtube.com/watch?v=gqpJ7RE02Ao)
 

Consultas varias
JellyFin
gBittorret
rancher
grafana
syncthing
seafile 

Monitoreo https://www.youtube.com/watch?v=PCJwJpbln6Q
 
