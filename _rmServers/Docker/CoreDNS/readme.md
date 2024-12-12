# <img src="./logo-CoreDNS.png" alt="CoreDNS Logo"/>

**CoreDNS** es un servidor DNS de código abierto, modular y altamente escalable, diseñado para gestionar la resolución de nombres en aplicaciones modernas. Es compatible con arquitecturas en contenedores, como Kubernetes, y ofrece una configuración flexible a través de sus plugins. CoreDNS puede actuar como un servidor DNS tradicional o como un proxy DNS, adaptándose a una variedad de entornos y necesidades.

- 📚 Más información:
  - [Sitio oficial de CoreDNS](https://coredns.io)
  - [Manual CoreDNS: DNS and Service Discovery](https://coredns.io/manual/toc/)
- 🎥 Videos recomendados:
  - [**EL MEJOR DNS para Docker - CoreDNS [DNS Parte 2]**](https://youtu.be/tE9YjEV1T4E?si=KR9xqJ6ZIVuAAIhW) - por [**Pelado Nerd**](https://www.youtube.com/@PeladoNerd)

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

# Versión: 241212-1856

# Variables de configuración
dkr_NOM="coredns"                        # Nombre del contenedor
dkr_POR=53                                # Puerto del contenedor
dkr_TMZ="America/Argentina/La_Rioja"      # Zona horaria

# Configuración del archivo docker-compose
dkr_CFG=$(cat <<-EOF

services:
    ${dkr_NOM}:
        volumes:
            - ./config:/root
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
echo "$dkr_CFG" | sudo tee "$dkr_YML" > /dev/null

# Ejecutar docker-compose
sudo docker-compose -f "$dkr_YML" up -d

# Mensaje de finalización
echo "Se ha desplegado correctamente en http://localhost:${dkr_POR}"

# tee rmDkrInstall_CoreDNS.sh <<'SHELL'
# SHELL
# chmod +x rmDkrInstall_CoreDNS.sh && ./rmDkrInstall_CoreDNS.sh
