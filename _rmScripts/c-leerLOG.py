# llamada
## python nombre_script.py archivo_log.txt directorio_salida/


import os
import sys

# Obtener el nombre del archivo y el directorio de la línea de comando
archivo = sys.argv[1]
directorio = sys.argv[2]

# Leer el archivo de registro de mensajes del kernel
with open(archivo, 'r') as f:
    lineas = f.readlines()

# Crear un diccionario vacío para almacenar las líneas de texto por fecha
fechas = {}

# Recorrer todas las líneas de texto del archivo
for linea in lineas:
    # Obtener la fecha a partir de la primera y segunda palabra
    fecha = linea.split()[0] + ' ' + linea.split()[1]
    
    # Agregar la línea al diccionario correspondiente a la fecha
    if fecha in fechas:
        fechas[fecha].append(linea)
    else:
        fechas[fecha] = [linea]

# Exportar las líneas de texto por fecha en archivos separados
for fecha, lineas in fechas.items():
    # Crear un nombre de archivo a partir de la fecha
    nombre_archivo = fecha.replace(' ', '_') + '.log'
    
    # Crear el archivo en el directorio especificado
    ruta_archivo = os.path.join(directorio, nombre_archivo)
    with open(ruta_archivo, 'w') as f:
        f.writelines(lineas)
