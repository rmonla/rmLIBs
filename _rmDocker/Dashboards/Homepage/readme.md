<!--  
# Ricardo MONLA (https://github.com/rmonla)
# Versión: 250109-2358 - rmDocker|Homepage
-->
# <img src="https://github.com/gethomepage/homepage/raw/dev/images/banner_light@2x.png" alt="Homepage Logo"/> Homepage

Este documento explica cómo configurar un contenedor Docker para implementar **Homepage**, una solución moderna y altamente personalizable diseñada para centralizar y gestionar accesos a aplicaciones, servicios y herramientas. Ideal para entornos de servidores y redes domésticas o empresariales, Homepage ofrece una interfaz intuitiva y organizada para optimizar la productividad.

---

## Enlaces de Consulta

- 📚 **Información del Aplicativo**:
  - [Sitio Oficial](https://gethomepage.dev)
  - [Repositorio en GitHub](https://github.com/gethomepage/homepage)
  - [Documentación Oficial](https://gethomepage.dev/latest)
- 🎥 **Videos Recomendados**:
  - [Meet Homepage - Your HomeLab Services Dashboard](https://youtu.be/mC3tjysJ01E) - por [**Techno Tim**](https://www.youtube.com/@TechnoTim)

---

## Características Destacadas

- **Dashboard centralizado:** Consolida el acceso a todas tus aplicaciones y servicios en un único panel intuitivo.
- **Interfaz moderna y adaptativa:** Diseño optimizado para dispositivos móviles y navegadores con soporte para temas claros y oscuros.
- **Fácil implementación:** Configuración rápida y sencilla utilizando Docker y Docker Compose.
- **Personalización avanzada:** Soporte para widgets, accesos directos y configuraciones adaptadas a tus necesidades.
- **Amplia compatibilidad:** Compatible con servicios populares como Sonarr, Radarr, Plex, Proxmox, Portainer, Uptime Kuma y más.
- **Gestión eficiente:** Reduce la complejidad al unificar múltiples accesos independientes.
- **Multiplataforma:** Funciona en Linux, macOS, Windows y entornos virtualizados o en contenedores Docker.

---

## Requisitos Previos

- **Sistema operativo:** Linux Debian (se requiere que `curl` esté instalado).
- Docker y Docker Compose instalados en el sistema.
- Espacio en disco adecuado para datos persistentes.
- Acceso a los puertos necesarios para la interfaz web y servicios relacionados.

---

## Configuración e Implementación

### 1. Ejecutar el Script de Despliegue `rmDkrUp-Homepage.sh`

Ejecuta el siguiente comando en tu terminal para descargar y ejecutar el script:

```bash
curl -sSL "https://github.com/rmonla/rmLIBs/raw/refs/heads/master/_rmDocker/Dashboards/Homepage/rmDkrUp-Homepage.sh" | bash
```

---

## Notas Adicionales

- **Detener el Contenedor:**
  Para detener y eliminar el contenedor en ejecución, utiliza el comando:

  ```bash
  docker compose down
  ```

- **Actualizar Homepage:**
  Si deseas actualizar a la última versión del contenedor, ejecuta:

  ```bash
  docker compose pull && docker compose up -d
  ```

- **Personalización:**
  Consulta la [documentación oficial](https://gethomepage.dev/latest) para explorar configuraciones avanzadas, definir temas personalizados, y adaptar la herramienta a tus necesidades específicas.

---

## ¡Invítame un Café! ☕

Si este proyecto te ha sido útil y deseas apoyar su desarrollo, considera invitarme un café. Cada contribución ayuda a mantener el flujo de trabajo y a mejorar herramientas como esta.  

[![Invítame un café](https://img.shields.io/badge/Invítame%20un%20café-%23FFDD00?style=for-the-badge&logo=buymeacoffee&logoColor=white)](https://www.buymeacoffee.com/rmonla)

---

> Este documento está basado en los estándares y prácticas recomendadas para implementaciones autohospedadas con Docker. Asegúrate de realizar un monitoreo regular y mantener el sistema actualizado.
