<?php 

	$lnk = '{ 
		"dticServTec" : {
			"titp" : "ServTec - UTNLaRioja",
			"titw" : "Sistema de Servicio Técnico DTIC - UTNLaRioja",
			"desc" : "Sistema que permite la administración y gestión del parque informático de la Facultad como así también el registro, mediante ordenes de servicio, de las distintas reparacines y mantenimiento del mismo.",
			"imag" : "minia.jpg",
			"time" : 1,
			"dest" : "https://docs.google.com/forms/d/e/1FAIpQLSejI-oFj2r3tVjpdDm85leMpfugB864Ieex4jGKykX1hKBTNQ/viewform"
			}
		}';

	$lnk = json_decode($lnk);

	
	echo '<pre>'.print_r( $lnk->{'dticServTec'}, true ).'</pre>';

	echo ( isset( $lnk->{'dticServTec2'} ))? "Existe" : "NoExiste";
	exit;


	// Array JSON:
		$someJSON = '[
			{"name":"Jonathan Suh","gender":"male"},
			{"name":"William Philbin","gender":"male"},
			{"name":"Allison McKinnery","gender":"female"}
		]';

	// Convert JSON string to Object
		$someObject = json_decode($someJSON);
		print_r($someObject);      // Dump all data of the Object
		echo $someObject[0]->name; // Access Object data


 ?>