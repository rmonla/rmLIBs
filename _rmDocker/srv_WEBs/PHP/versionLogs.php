<?php
$versionLogs = [
    '5.5.3' => [
        'date' => '2024-12-22',
        'changes' => [
            'Reorganización de archivos y directorios, trasladándolos de la carpeta "src" a la raíz del sitio.',
            'Creación de la herramienta "Ver Versiones" (tools/verVersiones.php) para mostrar el historial de cambios.',
            'Incorporación de los botones "Anterior" y "Siguiente" en (play.php) para una navegación más intuitiva.',
            'Modificación de estilos para mejorar la apariencia de los botones (css/style.css).',
            'Separación de las cabeceras y pies de página para incluirlos de forma independiente (include/header.php y include/footer.php).',
            'Actualización de index.php y play.php para utilizar include/header.php e include/footer.php.'
        ],
    ],
];

// Ordena las claves del array en orden descendente
uksort($versionLogs, 'version_compare');
$latestVersion = array_key_last($versionLogs);
$latestDetails = $versionLogs[$latestVersion];
?>
