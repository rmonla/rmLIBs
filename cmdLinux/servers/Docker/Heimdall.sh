sudo mkdir -p /docker/heimdall && sudo tee /docker/heimdall/docker-compose.yml > /dev/null <<EOF
---
services:
  heimdall:
    image: lscr.io/linuxserver/heimdall:latest
    container_name: heimdall
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Etc/UTC
    volumes:
      - /path/to/heimdall/config:/config
    ports:
      - 80:80
      - 443:443
    restart: unless-stopped
EOF

sudo docker-compose -f /docker/heimdall/docker-compose.yml up -d
