<?php  

	function rmUrl(){
	    if(isset($_SERVER['HTTPS']))
	        $protocol = ($_SERVER['HTTPS'] && $_SERVER['HTTPS'] != "off") ? "https" : "http";
	    else
	        $protocol = 'http';
	    return $protocol . "://" . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];
	}

	/**
	 * Redireccionador de páginas.
	 */

	$des = 'Systema de administración de documentos UTNLaRioja - DTIC.';
	
	$tit = 'UTNLR DMS';
	
	$ima = rmUrl() . 'miniatura.jpeg';
	
	$dst = 'https://drive.google.com/drive/folders/1X4U4pHb8ZSGrwlXCZp2PcPxo4KUP7uuv?usp';
	
	$tpo = 5;   //tiempo expresado en segundos.



	$pag = <<<HTML

<html>
	<head>
		<meta name="description" content="$des">
		<meta property="og:title" content="$tit" />
		<meta property="og:image" content="$ima" />
		<meta http-equiv="Refresh" content="$tpo;url=$dst">
	</head>
	<body>
		<p>Redirección automática en $tpo segundos o puedes acceder haciendo click <a href="$dst">aquí</a></p>
	</body>
</html>

HTML;

	echo $pag;
?>