```shell

#!/bin/bash

# Variables de configuración
dirDST="rmWebs"                            

# Array de VMs con sus UUIDs
vmARR=(
    ["x_srv-Proxy2"]="f5ad589c-84bd-9882-fbc8-76439e937332"
    ["srv-MauriK"]="21c5567b-c4c5-14b5-c70c-9b4e8b506c4c"
    ["srv-Sitio1"]="6d54b7f3-107e-5b7e-d77d-8c4c5ef9ebc0"
)

# Iterar sobre el array
for vmNOM in "${!vmARR[@]}"; do
    vmUID="${vmARR[$vmNOM]}"
    
    # Construir el destino
    vmFILE="${dirDST}/${vmNOM}_$(date +'%y%m%d-%H%M').xva"
    
    # Exportar la VM y copiar a destino
    xe vm-export uuid="$vmUID" filename="$vmFILE"
    
    echo "Iteración completada para VM: $vmNOM"
done

```
