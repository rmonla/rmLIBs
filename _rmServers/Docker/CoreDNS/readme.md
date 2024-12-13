# <img src="https://coredns.io/images/coredns.png" alt="CoreDNS Logo" width="100"/> CoreDNS

**CoreDNS** es un servidor DNS de código abierto, modular y altamente escalable, diseñado para gestionar la resolución de nombres en aplicaciones modernas. Es compatible con arquitecturas en contenedores, como Kubernetes, y ofrece una configuración flexible a través de sus plugins. CoreDNS puede actuar como un servidor DNS tradicional o como un proxy DNS, adaptándose a una variedad de entornos y necesidades.

- 📚 Más información:
  - [Sitio oficial de CoreDNS](https://coredns.io)
  - [Documentación oficial](https://coredns.io/docs/)
- 🎥 Videos recomendados:
  - [**How to Set Up CoreDNS in Docker**](https://youtu.be/A6vcTIzp_Ww?si=j4d0gjg9yrzVLnv5) - por [**TechHut**](https://www.youtube.com/@TechHut)

---

### Características destacadas
- **Modularidad:** Diseñado con una arquitectura basada en plugins para agregar funcionalidades según sea necesario.
- **Escalabilidad:** Ideal para entornos dinámicos como Kubernetes, gestionando DNS para servicios en contenedores.
- **Compatibilidad:** Compatible con múltiples protocolos DNS, como TCP, UDP y gRPC.
- **Alto rendimiento:** Optimizado para manejar grandes volúmenes de solicitudes DNS de manera eficiente.
- **Fácil configuración:** Archivos de configuración simples y flexibles, que permiten adaptarse rápidamente a diversas necesidades.
- **Soporte para Kubernetes:** Integración nativa para gestionar entradas DNS en clústeres de Kubernetes.

---

## Script `rmDkrInstall_CoreDNS.sh`
Este script automatiza la configuración y el despliegue de CoreDNS utilizando contenedores Docker.

```bash
#!/bin/bash
# Script para configurar y desplegar CoreDNS en Docker

# Versión: 241212-2153

# Variables de configuración
dkr_NOM="coredns"                        
dkr_POR=53                                
# dkr_TMZ="America/Argentina/La_Rioja"      
cfg_DIR="config"      # Zona horaria

# Configuración del archivo docker-compose
cfg_DKR=$(cat <<-EOF
services:
    ${dkr_NOM}:
        volumes:
            - ./${cfg_DIR}:/root
        ports:
            - ${dkr_POR}:53/udp
        image: coredns/coredns
        command: -conf /root/coredns.cfg

EOF
)

# Crear directorio y archivo docker-compose con la configuración
dkr_DIR="/docker/$dkr_NOM"
dkr_YML="$dkr_DIR/docker-compose.yml"

sudo mkdir -p "$dkr_DIR" 
echo "$cfg_DKR" | sudo tee "$dkr_YML" > /dev/null

# Configuracion del CoreDNS
file_ZONE="$dkr_NOM.zone"
file_CORE="$dkr_NOM.cfg"

cfg_CORE=$(cat <<-EOF
.:53 {
    forward . 8.8.8.8 9.9.9.9
    log
    errors
}

dns.frlr.utn.edu.ar:53 {
    file /root/${file_ZONE}
    log
    errors
}
EOF
)

cfg_ZONE=$(cat <<-EOF
ejemplo.com.        IN  SOA ns1.ejemplo.com. peladonerd.ejemplo.com. 2015082542 7200 3600 1209600 3600
server1.ejemplo.com.    IN  A   192.168.1.1
server2.ejemplo.com.    IN  A   192.168.1.2
server3.ejemplo.com.    IN  A   192.168.1.3
server4.ejemplo.com.    IN  A   192.168.1.3
www.ejemplo.com.        IN  CNAME   server1

_minecraft._tcp.ejemplo.com.   86400 IN    SRV 10       60     25565 server1.ejemplo.com.
_minecraft._tcp.ejemplo.com.   86400 IN    SRV 10       20     25565 server2.ejemplo.com.
_minecraft._tcp.ejemplo.com.   86400 IN    SRV 10       20     25565 server3.ejemplo.com.
_minecraft._tcp.ejemplo.com.   86400 IN    SRV 20       0      25565 server4.ejemplo.com.
EOF
)


dir_CFG="$dkr_DIR/$cfg_DIR"
sudo mkdir -p "$dir_CFG" 
echo "$cfg_CORE" | sudo tee "$dir_CFG/$file_CORE" > /dev/null
echo "$cfg_ZONE" | sudo tee "$dir_CFG/$file_ZONE" > /dev/null


# Ejecutar docker-compose
sudo docker-compose -f "$dkr_YML" up -d

# Mensaje de finalización
echo "Se ha desplegado correctamente en http://localhost:${dkr_POR}"

# tee rmDkrInstall_CoreDNS.sh <<'SHELL'
# SHELL
# chmod +x rmDkrInstall_CoreDNS.sh && ./rmDkrInstall_CoreDNS.sh
