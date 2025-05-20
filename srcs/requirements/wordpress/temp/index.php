// generated with deepseek, I currently know almost nothing of php

<?php
// Database configuration
$host = 'mariadb';
$user = 'root';
$pass = '1234';
$db = 'my_db';

// Connect using MySQLi (WordPress compatible)
$conn = new mysqli($host, $user, $pass, $db);

// Check connection
if ($conn->connect_error) {
    die("<h1 style='color:red'>Connection failed: " . $conn->connect_error . "</h1>");
}

// Create table if not exists
$conn->query("CREATE TABLE IF NOT EXISTS test_connection (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)");

// Generate and insert random message
$randomMessages = [
    "Hello from PHP-FPM!",
    "Database connection works!",
    "Docker networking is configured properly",
    "MySQLi extension is functioning",
    "Ready for WordPress installation",
    "Test message " . uniqid()
];

$randomMessage = $randomMessages[array_rand($randomMessages)] . " " . gethostname();
$conn->query("INSERT INTO test_connection (message) VALUES ('$randomMessage')");

// Display all messages
$result = $conn->query("SELECT * FROM test_connection ORDER BY created_at DESC");
?>

<!DOCTYPE html>
<html>
<head>
    <title>Database Test</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 2em; }
        .success { color: green; }
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <h1 class="success">✅ Database Connection Successful</h1>
    <p>Host: <?php echo $host; ?>, Database: <?php echo $db; ?></p>
    
    <h2>New Message Added:</h2>
    <p>"<?php echo htmlspecialchars($randomMessage); ?>"</p>
    
    <h2>All Messages in test_connection:</h2>
    <?php if ($result->num_rows > 0): ?>
        <table>
            <tr>
                <th>ID</th>
                <th>Message</th>
                <th>Created At</th>
            </tr>
            <?php while($row = $result->fetch_assoc()): ?>
                <tr>
                    <td><?php echo $row['id']; ?></td>
                    <td><?php echo htmlspecialchars($row['message']); ?></td>
                    <td><?php echo $row['created_at']; ?></td>
                </tr>
            <?php endwhile; ?>
        </table>
    <?php else: ?>
        <p>No messages found in the table.</p>
    <?php endif; ?>

    <p><em>Refresh the page to add another random message.</em></p>
</body>
</html>

<?php
$conn->close();
?>