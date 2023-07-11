# Smokeping

![Estado: Analizando](https://img.shields.io/badge/Estado-Analizando-brightgreen)
![Versión: 1.4](https://img.shields.io/badge/Versión-1.4-blue)
[![Autor: Lic. Ricardo MONLA](https://img.shields.io/badge/Autor-Lic.%20Ricardo%20MONLA-orange)](mailto:rmonla@frlr.utn.edu.ar)
--------------  

## Fuente de estudio y análisis
**Monitorizando e interpretando la salud de una red con Smokeping, Francisco José Montilla Blanco** (Francisco José Montilla Blanco, Spain). Veremos cómo esta potente herramienta open source nos posibilita seguir con precisión la "salud" de una red de forma estructurada y cómo implantarla en beneficio de un (W)ISP:

1. Estrategias de implantación de Smokeping sobre una red WISP
2. Cómo "educar" la vista para identificar problemas y patrones anómalos al instante, y
3. Cómo aislarlos mediante estos mismos gráficos con ejemplos reales.

- Ver el Video: [Monitorizando e interpretando la salud de una red con Smokeping](https://www.youtube.com/watch?v=lZfhO_jTv84)
- Ver el PDF: [presentation_3915_1474361765.pdf](presentation_3915_1474361765.pdf)
- Sitio oficial de Smokeping: [https://oss.oetiker.ch/smokeping/](https://oss.oetiker.ch/smokeping/)


## Descripción
Smokeping es una herramienta de monitoreo de red de código abierto que se utiliza para medir y visualizar el rendimiento y la disponibilidad de una red. Proporciona información sobre el tiempo de respuesta y la pérdida de paquetes de los dispositivos y servicios en una red.

Smokeping utiliza el protocolo ICMP (Internet Control Message Protocol) para enviar pings a los dispositivos y servicios objetivo, y luego registra y grafica los resultados en forma de gráficos de latencia y pérdida de paquetes a lo largo del tiempo.

Además, Smokeping ofrece alertas configurables que pueden notificar a los administradores cuando se superan umbrales definidos para los tiempos de respuesta o la pérdida de paquetes, lo que ayuda a identificar problemas de red y tomar medidas correctivas de manera oportuna.

En resumen, Smokeping es una herramienta útil para monitorear y visualizar el rendimiento de la red, lo que permite a los administradores detectar y solucionar problemas de red, así como tomar decisiones informadas para mejorar la calidad y confiabilidad de la red.
 
## Requisitos de Hardware

| Requisito    | Descripción                                                                                     |
|--------------|-------------------------------------------------------------------------------------------------|
| Procesador   | Se recomienda un procesador de al menos 1 GHz o superior. Mayor capacidad de procesamiento es beneficiosa para un alto volumen de peticiones de ping. |
| Memoria RAM  | Se recomienda al menos 1 GB de RAM. Para redes más grandes o con muchas sondas, se puede necesitar más memoria. |
| Almacenamiento | No se requiere mucho espacio de almacenamiento para Smokeping en sí. Sin embargo, se necesita más espacio si se desea mantener un historial de datos extenso. |
| Conexión de red | Se necesita una conexión de red estable y confiable para realizar pruebas de ping. Asegúrate de tener una conexión confiable con suficiente ancho de banda. |

## Debian Install
~~~bash
sudo apt-get install smokeping
~~~

## Archivo de configuración
~~~bash
sudo nano /usr/local/etc/smokeping/config
~~~
