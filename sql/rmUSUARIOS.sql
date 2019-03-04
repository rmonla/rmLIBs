-- rmUSUARIOS.sql: Bibliteca sobre USUARIOS.

/**
 * Commando para acceder a mysql desde consola en linux.
 */
	sudo mysql -u root -p

/**
 * Crear usuario desde consola.
 */
CREATE USER 'rmonla'@'localhost' IDENTIFIED BY 'password';

/**
 * Conceder todos los privilegios en todas las tablas.
 */
GRANT ALL PRIVILEGES ON * . * TO 'rmonla'@'localhost';

/**
 * Conceder pribilegios a usuario en tabla específica.
 */
GRANT ALL PRIVILEGES ON rmUTNSaa . * TO 'rmUTNSaa'@'localhost';
