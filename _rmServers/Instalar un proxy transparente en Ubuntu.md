# Instalar un proxy transparente en Ubuntu

![Estado: Inestable](https://img.shields.io/badge/Estado-Inestable-red)
![Versión: 0.1](https://img.shields.io/badge/Versión-0.1-blue)
[![Autor: Lic. Ricardo MONLA](https://img.shields.io/badge/Autor-Lic.%20Ricardo%20MONLA-orange)](mailto:rmonla@frlr.utn.edu.ar)


Para instalar un proxy transparente en Ubuntu, puedes utilizar Squid, que es un servidor proxy muy popular y ampliamente utilizado. Aquí tienes los pasos para instalarlo:

** Paso 1: Actualiza el sistema
	sudo apt update
	sudo apt upgrade

** Paso 2: Instala Squid
	sudo apt install squid

** Paso 3: Configura Squid como proxy transparente
	sudo nano /etc/squid/squid.conf

	Dentro del archivo de configuración, busca y modifica las siguientes líneas:

	http_port 3128 transparent

	Guarda los cambios y cierra el archivo.

** Paso 4: Reinicia Squid para aplicar la configuración
	sudo service squid restart

** Paso 5: Configura iptables para redirigir el tráfico al proxy Squid
	sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 3128

** Paso 6: Guarda la configuración de iptables
	sudo iptables-save > /etc/iptables/rules.v4

** Paso 7: Habilita la persistencia de iptables
	sudo nano /etc/rc.local

	Agrega la siguiente línea antes de la etiqueta "exit 0":

	iptables-restore < /etc/iptables/rules.v4

	Guarda y cierra el archivo.

** Paso 8: Reinicia el sistema para aplicar los cambios
	sudo reboot

	Después de reiniciar, Squid actuará como un proxy transparente en el puerto 3128 y redirigirá todo el tráfico HTTP (puerto 80) a través del proxy sin requerir configuraciones adicionales en los navegadores de los clientes.

Ten en cuenta que la configuración de un proxy transparente puede tener implicaciones en la privacidad y seguridad de la red. Asegúrate de entender y ajustar adecuadamente las políticas de acceso y seguridad en Squid para satisfacer tus necesidades específicas.