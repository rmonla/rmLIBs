# rmLIBs - XenServer

## Backup de la BD de configuración del Pool [El servidor Master en XenServer](https://www.josemariagonzalez.es/citrix/el-servidor-master-en-xenserver.html)
### Archivo de la BD:
    /var/xapi/state.db
### Respaldar BD.
    xe pool-dump-database file-name=<path and filename>
### Restaurar Backup de BD.
    xe pool-restore-database file-name=<path to backup file>

Con esto vamos a tener que reiniciar y la base de datos volverá a estar operativa, con toda la configuración de Storage, máquinas virtuales, redes, etc….
