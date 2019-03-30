<?php  
	// rmLeePlanillaGoogle.php

	// Leer un php desde html no se puede, al revés sí, pero no es lo que necesitas. 
	// La función que te interesa es esta http://php.net/manual/es/function.fgetcsv.php 
	// uno de los parámetros de la función es la ruta del archivo CSV, si es un archivo que está online, la ruta es su URL (en tu caso, la que te da Google Drive al hacerlo público ). 
	// Aquí tienes un ejemplo http://stackoverflow.com/questions/21189665/new-google-spreadsheets-publish-limitation 
	// saludos !!
	// 
	// The new Google spreadsheets use a different URL (just copy your <KEY>):
	// 
	// New sheet : https://docs.google.com/spreadsheets/d/<KEY>/pubhtml
	// CSV file : https://docs.google.com/spreadsheets/d/<KEY>/export?gid=<GUID>&format=csv
	// The GUID of your spreadsheet relates to the tab number.
	// 
	// /!\ You have to share your document using the Anyone with the link setting.
	// https://docs.google.com/spreadsheets/export?id=10U_tBM50CLvyd3JUgi9giBx4Y5AbTkM2GL0kxSC8YJo&exportFormat=csv

?>
