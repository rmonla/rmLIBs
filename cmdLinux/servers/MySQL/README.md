# MaySQL Server

![Estado: EnPruebas](https://img.shields.io/badge/Estado-EnPruebas-brightgreen)
![Versión: 0.1](https://img.shields.io/badge/Versión-0.1-blue)
[![Autor: Lic. Ricardo MONLA](https://img.shields.io/badge/Autor-Lic.%20Ricardo%20MONLA-orange)](mailto:rmonla@frlr.utn.edu.ar)
--------------  

A). [**WebMIN Downloading and Installing**](https://webmin.com/download/) 
  1. Ejecuto el configurador del repositorio
~~~bash
curl -o setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh && sudo sh setup-repos.sh
~~~
  2. Instalar el aplicativo.
~~~bash
sudo apt-get install webmin --install-recommends -y
~~~

### La instalación se probó con éxito y funcionó en Ubuntu Server 22.
