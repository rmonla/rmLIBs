@echo off
rem rmBootWX.cmd: Lista de comandos para generar un pendrive booteable de Windows 10.

echo.
echo === Configuración del disco ===
echo.

echo Seleccione el disco a utilizar:
echo.

rem Obtener la lista de discos usando el comando wmic
for /f "skip=1 delims=" %%d in ('wmic diskdrive list brief') do (
  for /f "tokens=1,*" %%s in ("%%d") do echo %%s. %%t
)

echo.

set /p diskNumber="Ingrese el número de disco a utilizar: "
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
