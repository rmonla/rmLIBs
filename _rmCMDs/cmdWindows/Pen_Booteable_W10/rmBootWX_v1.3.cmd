@echo off
rem rmBootWX.cmd: Lista de comandos para generar un pendrive booteable de Windows 10.

:: Configuración de variables de mensajes
set "msgSelDisco=Seleccione el disco a utilizar para formatear:"
set "msgSelOrigen=Seleccione la unidad de origen (por ejemplo, E): "
set "msgSelDestino=Seleccione la unidad de destino (por ejemplo, F): "
set "msgCopiando=Copiando los archivos de Windows..."
set "msgCompletadoProcss=Proceso completado."
set "msgCompletadoPenDrive=El pendrive booteable de Windows 10 se ha creado correctamente en %discoDST%."

:: Ayuda y uso
echo Generador de Pendrive Booteable de Windows 10
echo ----------------------------------------------
echo Este script formateará un disco USB y copiará los archivos de Windows 10 para hacerlo booteable.
echo.
echo Instrucciones:
echo 1. Conecte el pendrive USB.
echo 2. Monte el archivo ISO en una unidad.
echo 3. Ejecute este script y siga las instrucciones.
echo.

:: Solicitar confirmación para continuar
set /p continueMsg="Presione Enter para continuar o Ctrl+C para salir..."

echo.
echo === Configuración de disco booteable ===
echo.

echo %msgSelDisco%
echo.

:: Listar los discos disponibles
for /f "skip=1 delims=" %%d in ('wmic diskdrive list brief') do (
  for /f "tokens=1,*" %%s in ("%%d") do echo %%s. %%t
)

echo.
set /p discoID="Ingrese el número de disco a utilizar: "
echo.

rem Configuración de disco usando diskpart
(
  echo select disk %discoID%
  echo clean
  echo create partition primary
  echo active
  echo format fs=ntfs quick label=RMBOOTWX
  echo assign
  echo exit
) | diskpart

echo.
echo === Seleccione la unidad de origen ===
echo.

echo Unidades disponibles:
echo.

for /f "skip=1 delims=" %%d in ('wmic logicaldisk get caption') do (
  for /f "tokens=1" %%s in ("%%d") do echo %%s
)

echo.

set /p discoORI="%msgSelOrigen%"
set discoORI=%discoORI%:\

echo.
echo === Seleccione la unidad de destino ===
echo.

echo Unidades disponibles:
echo.

for /f "skip=1 delims=" %%d in ('wmic logicaldisk get caption') do (
  for /f "tokens=1" %%s in ("%%d") do echo %%s
)

echo.

set /p discoDST="%msgSelDestino%"
set discoDST=%discoDST%:\

echo.
echo %msgCopiando%
echo.

:: Copiar archivos de Windows
xcopy %discoORI%*.* %discoDST% /s /e /f

echo.
echo %msgCompletadoProcss%
echo.
echo %msgCompletadoPenDrive%

pause
exit
