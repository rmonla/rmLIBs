<?php  
	
	include_once 'rmMyURL.php';

	$tit = 'UTNLR DMS'; 
	$des = 'Systema de administración de documentos UTNLaRioja - DTIC.';
	$dst = 'http://192.168.7.88/';
	$ima = rmMyURL() . 'miniatura.jpeg';
	$tpo = 3;

	/**
	 * rmRedir: Redirecciona a una URL diferente.
	 * @param  string  $tit Título del link de destino.
	 * @param  string  $des Descripción del contenido de destino.
	 * @param  string  $dst Url de destino donde se redirecciona.
	 * @param  string  $ima Imágen .jpeg miniatura.
	 * @param  integer $tpo Tiempo en segundos que espera para redireccionar.
	 * @return HTML         Código html retornado en realción a las variables entregadas.
	 */
	function rmRedir(
		$tit = '', 
		$des = '',
		$dst = '',
		$ima = '',
		$tpo = 2  //tiempo expresado en segundos.
		){
		
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

	}

	// var_dump( list($dats) );
	// rmRedir( $dats );
	// rmRedir( (list($dats)) );
	rmRedir( $tit, $des, $dst, $ima, $tpo);

?>