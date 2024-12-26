<?php 
include 'incs/header.php'; 
include 'incs/versionLogs.php'; 
?>
<main class="main-content">
    <section class="playlist">
        <h2>>Historial de Versiones</h2>
        <?php foreach ($versionLogs as $version => $log): ?>
            <div class="version-log">
                <div class="version-title">Versión: <?= htmlspecialchars($version) ?></div>
                <div class="date">Fecha: <?= htmlspecialchars($log['date']) ?></div>
                <ul class="change-list">
                    <?php foreach ($log['changes'] as $change): ?>
                        <li><?= htmlspecialchars($change) ?></li>
                    <?php endforeach; ?>
                </ul>
            </div>
        <?php endforeach; ?>
    </section>
</main>
<?php include 'incs/footer.php'; // Incluir pie de página ?>