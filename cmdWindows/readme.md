# Ejemplo de un instalador
    REM extracting the cab file to current directory
    extrac32.exe /Y /A /E files.cab
    REM changing the directory to "Files"
    CD Files
    REM executing setup.exe in Files folder.
    START /WAIT %~dp0\Files\setup.exe
    
 
