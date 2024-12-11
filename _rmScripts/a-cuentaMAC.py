import re
import sys
from collections import Counter

# Definimos la expresión regular para buscar direcciones MAC en el archivo
regex_mac = re.compile(r"MAC=([a-fA-F0-9]{2}(?::[a-fA-F0-9]{2}){5})")

# Abrimos el archivo y leemos todas las líneas
with open(sys.argv[1], 'r') as f:
    lines = f.readlines()

# Buscamos todas las direcciones MAC y contamos su frecuencia
macs = [regex_mac.search(line).group(1) for line in lines if regex_mac.search(line)]
counter = Counter(macs)

# Ordenamos el resultado por frecuencia de aparición en orden descendente
result = sorted(counter.items(), key=lambda x: x[1], reverse=True)

# Imprimimos el resultado
for mac, count in result:
    print(f"{mac}: {count}")
