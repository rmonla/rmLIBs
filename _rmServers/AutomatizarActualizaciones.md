# Automatizar Actualizaciones en Linux con `unattended-upgrades`

![Estado: En Producción](https://img.shields.io/badge/Estado-En%20Producción-yellow)
![Versión: 0.2](https://img.shields.io/badge/Versión-0.1-yellow)
[![Autor: Lic. Ricardo MONLA](https://img.shields.io/badge/Autor-Lic.%20Ricardo%20MONLA-orange)](mailto:rmonla@gmail.com)

## 📋 Índice

1. [Descripción](#descripción)
2. [Instalación de `unattended-upgrades`](#instalación-de-unattended-upgrades)
3. [Configuración de `unattended-upgrades`](#configuración-de-unattended-upgrades)
4. [Referencias](#referencias)

## 📝 Descripción

En este documento se explica cómo automatizar las actualizaciones de seguridad en sistemas Linux usando la herramienta `unattended-upgrades`. Esta utilidad permite mantener los sistemas actualizados automáticamente, reduciendo la necesidad de intervención manual y mejorando la seguridad.

## ⚙️ Instalación de `unattended-upgrades`

### 1. Actualizar el sistema

Antes de instalar `unattended-upgrades`, es recomendable asegurarse de que el sistema esté completamente actualizado.

```bash
sudo apt update && sudo apt upgrade -y
```

### 2. Instalar `unattended-upgrades`

Instala la herramienta `unattended-upgrades` utilizando el siguiente comando:

```bash
sudo apt install unattended-upgrades -y
```

Una vez instalada, la herramienta estará lista para ser configurada.

## 🔧 Configuración de `unattended-upgrades`

### 1. Configurar `unattended-upgrades`

Para configurar las actualizaciones automáticas, edita el archivo de configuración:

```bash
sudo dpkg-reconfigure unattended-upgrades
```

**Pasos**:
- Ejecuta el comando anterior.
- Selecciona "Sí" para permitir las actualizaciones automáticas de seguridad.

![Configuración de unattended-upgrades](https://diocesanos.es/blogs/equipotic/wp-content/uploads/sites/2/2021/06/Captura-de-pantalla-2021-06-28-13-38-01.png)

### 2. Editar el archivo de configuración manualmente (Opcional)

Si deseas ajustar la configuración de manera más personalizada, puedes editar directamente el archivo `/etc/apt/apt.conf.d/50unattended-upgrades`:

```bash
sudo nano /etc/apt/apt.conf.d/50unattended-upgrades
```

Algunas opciones clave que puedes modificar incluyen:
- **Permitir o denegar actualizaciones de ciertos paquetes**.
- **Configurar notificaciones de correo electrónico** en caso de errores o actualizaciones completadas.

    ```plaintext
    Unattended-Upgrade::Mail "tu_email@dominio.com";
    ```

    ![Editar archivo de configuración](https://example.com/imagen_editar_configuracion.png)

### 3. Activar `unattended-upgrades` (Opcional)

Para asegurarte de que `unattended-upgrades` esté activo y funcionando correctamente, puedes habilitarlo explícitamente:

```bash
sudo systemctl enable --now unattended-upgrades
```

## 🔗 Referencias

- [Unattended Upgrades: cómo automatizar las actualizaciones de nuestro Linux](https://diocesanos.es/blogs/equipotic/2021/06/28/unattended-upgrades-como-automatizar-las-actualizaciones-de-nuestro-linux/)
