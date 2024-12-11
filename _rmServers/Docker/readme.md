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
### 🎥 Videos recomendados:
  - [**TechHut**](https://www.youtube.com/@TechHut)
    - [my FAVORITE Home Server Dashboard - Homarr Setup in Docker](https://youtu.be/A6vcTIzp_Ww?si=j4d0gjg9yrzVLnv5) ☑️
    - [my NEW Proxmox Media Server - Full Walkthrough Guide Pt.2 (Jellyfin, Sonarr, Gluetun, and MORE)](https://www.youtube.com/watch?v=Uzqf0qlcQlo)
  - [**No Solo Hacking**](https://www.youtube.com/@NoSoloHacking)
    - [ DIETPI - #Sonarr + #PLEX + #Jellyfin + #Transmission + #Jackett - ACTUALIZADO ](https://www.youtube.com/watch?v=I93VHAlpRsY)
- [**nanoninja**](https://github.com/nanoninja)
    - [docker-nginx-php-mysql](https://github.com/nanoninja/docker-nginx-php-mysql)   
