import os

archivo_log = "syslog"
directorio_salida = "./lectura1/"

# Crear el directorio de salida si no existe
if not os.path.exists(directorio_salida):
    os.makedirs(directorio_salida)

# Leer el archivo de log y separar las líneas por fecha
with open(archivo_log, "r") as f:
    lineas_por_fecha = {}
    for linea in f:
        # Obtener la fecha de la línea
        fecha = linea.split()[0]  # La fecha es la primera palabra de la línea
        if fecha not in lineas_por_fecha:
            # Si es la primera vez que se encuentra esta fecha, crear un nuevo archivo
            archivo_salida = os.path.join(directorio_salida, fecha + ".log")
            lineas_por_fecha[fecha] = open(archivo_salida, "w")
        # Escribir la línea en el archivo correspondiente
        lineas_por_fecha[fecha].write(linea)

# Cerrar los archivos de salida
for archivo in lineas_por_fecha.values():
    archivo.close()
