# logsBKPs.md

![Estado: Estable](https://img.shields.io/badge/Estado-Estable-brightgreen)
![Versión: 1.10](https://img.shields.io/badge/Versión-0.1-blue)
[![Autor: Lic. Ricardo MONLA](https://img.shields.io/badge/Autor-Lic.%20Ricardo%20MONLA-orange)](mailto:rmonla@frlr.utn.edu.ar)
--------------  

## logsBKPs.sh

El código es un script de shell (bash) que realiza copias de respaldo de archivos en el directorio "/var/log" con un tamaño mayor a 500MB. Luego, guarda los registros en un archivo llamado "bkps.log". Si hay más de 30 líneas en el archivo, muestra las últimas 30 líneas; de lo contrario, muestra el contenido completo. Además, muestra la fecha y hora actual y el espacio en disco del dispositivo "xvda".

 
## runLogsBKPs.sh

Ejecuta el script "logsBKP.sh" cada 5 minutos y muestra la salida actualizada en la pantalla.
