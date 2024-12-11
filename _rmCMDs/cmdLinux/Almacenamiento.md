# Almacenamiento.md
## Consultar espacio de los discos.
### Ver espacio en discos.
- Ejecutar el siguiente comando:
  ```
  df -h
  ```

### Mostrar los 10 directorios más cargados.
- Ejecutar los siguientes comandos:
  ```
  du -a | sort -nr | head -n 10
  du -ahx . | sort -rh | head -10
  ```

