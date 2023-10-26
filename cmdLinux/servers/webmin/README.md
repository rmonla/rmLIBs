# Webmin

![Estado: Funciona](https://img.shields.io/badge/Estado-Analizando-brightgreen)
![Versión: 1.2](https://img.shields.io/badge/Versión-1.4-blue)
[![Autor: Lic. Ricardo MONLA](https://img.shields.io/badge/Autor-Lic.%20Ricardo%20MONLA-orange)](mailto:rmonla@frlr.utn.edu.ar)
--------------  

## Fuente de estudio y análisis
[**WebMIN Downloading and Installing**](https://webmin.com/download/) 

1. Ejecuto el configurador del repositorio
~~~bash
curl -o setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh && sudo sh setup-repos.sh
~~~
2. Instalar el aplicativo.
~~~bash
sudo apt-get install webmin --install-recommends -y
~~~

### La instalación se probó con éxito y funcionó en Ubuntu Server 22.
