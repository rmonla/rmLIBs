# Crear un Pendrive booteable de Windows 10
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
