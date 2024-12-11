import re
from collections import Counter
import sys

if len(sys.argv) < 2:
    print("Debe proporcionar un archivo como argumento.")
    sys.exit(1)

mac_regex = r"MAC=(?P<mac>(?:[0-9A-Fa-f]{2}[:-]){5}(?:[0-9A-Fa-f]{2}))"
src_regex = r"SRC=(?P<src>\d{1,3}(?:\.\d{1,3}){3})"
dst_regex = r"DST=(?P<dst>\d{1,3}(?:\.\d{1,3}){3})"

with open(sys.argv[1], 'r') as f:
    lines = f.readlines()

macs = []
srcs = []
dsts = []

for line in lines:
    mac_match = re.search(mac_regex, line)
    if mac_match:
        macs.append(mac_match.group("mac"))
        
    src_match = re.search(src_regex, line)
    if src_match:
        srcs.append(src_match.group("src"))
    
    dst_match = re.search(dst_regex, line)
    if dst_match:
        dsts.append(dst_match.group("dst"))

mac_counts = Counter(macs)
src_counts = Counter(srcs)
dst_counts = Counter(dsts)

print("Direcciones MAC más comunes:")
for mac, count in mac_counts.most_common():
    print(mac, count)

print("\nDirecciones IP de origen más comunes:")
for src, count in src_counts.most_common():
    print(src, count)

print("\nDirecciones IP de destino más comunes:")
for dst, count in dst_counts.most_common():
    print(dst, count)
