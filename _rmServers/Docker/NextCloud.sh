sudo mkdir -p /docker/nextcloud && sudo tee /docker/nextcloud/docker-compose.yml > /dev/null <<EOF
version: '3.9'

networks:
  nextcloud_network:

volumes:
  nextcloud:
  db:
  redis_data:
 
services:
  db:
    image: mariadb:10.6
    restart: always
    command: --transaction-isolation=READ-COMMITTED --log-bin=binlog --binlog-format=ROW
    volumes:
      - db:/var/lib/mysql
    networks:
      - nextcloud_network
    environment:
      - MYSQL_ROOT_PASSWORD=password
      - MYSQL_DATABASE=nextcloud
      - MYSQL_USER=nextcloud
      - MYSQL_PASSWORD=password

  redis:
    image: redis:latest
    restart: always
    hostname: redis
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data
    networks:
      - nextcloud_network
      
  app:
    image: nextcloud
    restart: always
    ports:
      - "7180:80"
    depends_on:
      - db
      - redis
    environment:
      - MYSQL_HOST=db
      - MYSQL_DATABASE=nextcloud
      - MYSQL_USER=nextcloud
      - MYSQL_PASSWORD=password
      - REDIS_HOST=redis
      - REDIS_PORT=6379
    volumes:
      - nextcloud:/var/www/html
    networks:
      - nextcloud_network

EOF

sudo docker-compose -f /docker/nextcloud/docker-compose.yml up -d
