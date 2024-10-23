DK_NOM="unifi"
DK_PRT="8080"
DK_DIR="/docker/$DK_NOM"
DK_CMP="$DK_DIR/docker-compose.yml"

sudo mkdir -p "$DK_DIR" 

cat <<EOF | sudo tee "$DK_CMP" > /dev/null
version: '3'

services:
  unifi:
    image: ghcr.io/goofball222/unifi
    container_name: unifi
    restart: unless-stopped
    network_mode: bridge
    ports:
      - 3478:3478/udp
      - "$DK_PRT":8080
      - 8443:8443
      - 8880:8880
      - 8843:8843
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - ./cert:/usr/lib/unifi/cert
      - ./data:/usr/lib/unifi/data
      - ./logs:/usr/lib/unifi/logs
    environment:
      - TZ=UTC
EOF

sudo docker-compose -f "$DK_CMP" up -d
