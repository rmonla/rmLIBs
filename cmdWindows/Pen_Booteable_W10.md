### rmBootWX.cmd
``` batch
@echo off
rem rmBootWX.cmd: Lista de comandos para generar un pendrive booteable de Windows 10.

echo.
echo === Configuración del disco ===
echo.

rem Utilizamos el número de disco proporcionado por el usuario
set /p diskNumber="Ingrese el número de disco a utilizar (ejemplo: 1): "
echo.

diskpart /s diskConfig.txt

echo.
echo === Copiando los archivos de Windows ===
echo.

xcopy E:\*.* /s /e /f F:\

echo.
echo === Proceso completado ===
echo.
echo El pendrive booteable de Windows 10 se ha creado correctamente.

pause
exit
```
### rmBootWXdisk.cfg
``` batch
list disk
select disk %diskNumber%
clean
create partition primary
select partition 1
active
format fs=ntfs quick label=RM-WX
assign
exit
```
