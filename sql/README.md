# Consulta SQL con varios conceptos INNER JOIN, CONCAT_WS, DATE_FORMAT.
rmINNER-JOIN.sql:
```sql
SELECT 
	ds.id, 
	ca.cod carr, 
	CONCAT_WS(' - ', CONCAT_WS('', cu.anio, '° Año' ), cu.cod ) orden, 
	m.mat, 
	dp.cod depto, 
	r.regi, 
	cu.hs_t ht, 
	cu.hs_p hp, 
	((cu.hs_t + cu.hs_p) * r.sems) htot, 
	ga.gradoa, 
	CONCAT_WS(', ', p.ape, p.nom) doc, 
	(select dt.designt from designts dt where dt.id = ds.iddesignt) desig, 
	ds.afect, 
	CONCAT_WS(' ', CONCAT_WS('_', dt3.doct, o.ori, f.cod), CONCAT_WS('/', doc.doc, YEAR(doc.fecha)) ) res, 
	ds.dedic, 
	dt2.dedit, 
	ds.dediv, 
	DATE_FORMAT(ds.dedid, '%d/%m/%y') dedid, 
	DATE_FORMAT(ds.dedih, '%d/%m/%y') dedih 
FROM designis ds 
INNER JOIN curris   cu  ON cu.id  = ds.idcurri 
INNER JOIN carrs    ca  ON ca.id  = cu.idcarr 
INNER JOIN mats     m   ON m.id   = cu.idmat 
INNER JOIN deptos   dp  ON dp.id  = cu.iddepto 
INNER JOIN regis    r   ON r.id   = cu.idregi 
INNER JOIN gradoas  ga  ON ga.id  = ds.idgradoa 
INNER JOIN conts    p   ON p.id   = ds.idper 
INNER JOIN dedits   dt2 ON dt2.id = ds.iddedit 
INNER JOIN docs     doc ON doc.id = ds.iddoc 
INNER JOIN docts    dt3 ON dt3.id = doc.iddoct 
INNER JOIN oris     o   ON o.id   = doc.idori 
INNER JOIN facus    f   ON f.id   = o.idfacu 
ORDER BY ca.carr, cu.anio, cu.cod, dsf.orden 
LIMIT 0,10
```

# Bibliteca sobre USUARIOS.
rmUSUARIOS.sql:
 * Commando para acceder a mysql desde consola en linux.
```bat
sudo mysql -u root -p
```
 * Crear usuario desde consola.
```sql
CREATE USER 'rmonla'@'localhost' IDENTIFIED BY 'password';
```
 * Conceder todos los privilegios en todas las tablas.
```sql
GRANT ALL PRIVILEGES ON * . * TO 'rmonla'@'localhost';
```
 * Conceder pribilegios a usuario en tabla específica.
```sql
GRANT ALL PRIVILEGES ON rmUTNSaa . * TO 'rmUTNSaa'@'localhost';
```
© 2022 GitHub, Inc.
Terms
Privacy
Security
Status
Docs
