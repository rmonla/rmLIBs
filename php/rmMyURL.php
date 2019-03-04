<?php 
	/**
	 * Analiza ubicación actual de la uri actual y la retorna completa con su protocolo correspondiente.
	 * @return [string] [URL completa con su protocolo correspondiente.]
	 * @author Ricardo MONLA <rmonla@gmail.com>
	 */
	function rmMyUrl(){
	    if(isset($_SERVER['HTTPS']))
	        $protocol = ($_SERVER['HTTPS'] && $_SERVER['HTTPS'] != "off") ? "https" : "http";
	    else 
	    	$protocol = 'http';
	    return $protocol . "://" . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];
	}
 ?>
