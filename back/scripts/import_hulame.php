<?php

declare(strict_types=1);

// Usage: php back/scripts/import_hulame.php "mysql://user:pass@host:port/db" "path/to/hulame.sql"

if ($argc < 3) {
    fwrite(STDERR, "Usage: php import_hulame.php <MYSQL_PUBLIC_URL> <sql_file>\n");
    exit(1);
}

$mysqlUrl = $argv[1];
$sqlFile = $argv[2];

if (!is_file($sqlFile)) {
    fwrite(STDERR, "SQL file not found: {$sqlFile}\n");
    exit(1);
}

$parts = parse_url($mysqlUrl);
if ($parts === false || !isset($parts['scheme']) || $parts['scheme'] !== 'mysql') {
    fwrite(STDERR, "Invalid MYSQL_PUBLIC_URL\n");
    exit(1);
}

$host = $parts['host'] ?? 'localhost';
$port = isset($parts['port']) ? (int)$parts['port'] : 3306;
$user = $parts['user'] ?? 'root';
$pass = $parts['pass'] ?? '';
$db   = isset($parts['path']) ? ltrim($parts['path'], '/') : '';

$dsn = sprintf('mysql:host=%s;port=%d;dbname=%s;charset=utf8mb4', $host, $port, $db);

echo "Connecting to {$host}:{$port}/{$db}...\n";

try {
    $pdo = new PDO($dsn, $user, $pass, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::MYSQL_ATTR_MULTI_STATEMENTS => true,
    ]);
} catch (Throwable $e) {
    fwrite(STDERR, "Connection failed: {$e->getMessage()}\n");
    exit(1);
}

$sql = file_get_contents($sqlFile);
if ($sql === false) {
    fwrite(STDERR, "Failed to read SQL file: {$sqlFile}\n");
    exit(1);
}

// Remove phpMyAdmin comments and SET statements that may fail
$lines = preg_split('/\r?\n/', $sql);
$filtered = [];
foreach ($lines as $line) {
    $trim = trim($line);
    if ($trim === '' || str_starts_with($trim, '--') || str_starts_with($trim, '/*')) {
        continue;
    }
    if (preg_match('/^SET\s/i', $trim) || preg_match('/^START\s+TRANSACTION/i', $trim) || preg_match('/^COMMIT;?$/i', $trim)) {
        continue;
    }
    $filtered[] = $line;
}
$sql = implode("\n", $filtered);

echo "Importing SQL from {$sqlFile}...\n";

try {
    $pdo->exec('SET FOREIGN_KEY_CHECKS=0');
    $pdo->exec($sql);
    $pdo->exec('SET FOREIGN_KEY_CHECKS=1');
    echo "Import complete.\n";
} catch (Throwable $e) {
    fwrite(STDERR, "Import failed: {$e->getMessage()}\n");
    exit(1);
}

exit(0);


