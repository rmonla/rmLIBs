# Crear un Pendrive booteable de Windows 7 o 10
```bat    
rem rmBootWX.cmd: Lista de comandos para generar un pendrive booteable de windows 10.
diskpart 
  list disk
  select disk 1
  clean
  create partition primary
  select partition 1
  active
  format fs=ntfs label=RM-WX quick
  assign
  exit

xcopy e:\*.* /s/e/f f:\
```

# Ejemplo de un instalador
```bat 
REM extracting the cab file to current directory
extrac32.exe /Y /A /E files.cab
REM changing the directory to "Files"
CD Files
REM executing setup.exe in Files folder.
START /WAIT %~dp0\Files\setup.exe
```
# Renombra archivos por lotes con parametros.
```bat 
@echo off
rem Recive por parametros la subcarpeta y el inicio del nombre para renombrar.

set DIR=%1
set PRE=%2
cd %DIR%
for %%i in (*.*) do ren %%i %PRE%_%%i
cd ..
```


# Ejecutar comandos multi hilos
```bat 
@echo off
for /l %%i in (1,2,200) do call :test %%i
goto :eof

:test
echo %1

rem goto test
goto :eof

:loop
call :checkinstances
if %INSTANCES% LSS 5 (
	rem just a dummy program that waits instead of doing useful stuff
	rem but suffices for now
	echo Starting processing instance for %1
	start /min wait.exe 5 sec
	goto :eof
)
rem wait a second, can be adjusted with -w (-n 2 because the first ping returns immediately;
rem otherwise just use an address that's unused and -n 1)
echo Waiting for instances to close ...
ping -n 2 ::1 >nul 2>&1
rem jump back to see whether we can spawn a new process now
goto loop
goto :eof

:checkinstances
rem this could probably be done better. But INSTANCES should contain the number of running instances afterwards.
for /f "usebackq" %%t in (`tasklist /fo csv /fi "imagename eq wait.exe"^|wc -l`) do set INSTANCES=%%t
goto :eof
```
