<!DOCTYPE html>
<html>
<head>
    <title>DATABASE SAMPLE</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #F5F7FA;
            color: #333;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        h1,h4 {
            text-align: center;
            color: #444;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th, td {
            padding: 8px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #eaf2f8;
            animation: colorChange 0.3s;
        }

        @keyframes colorChange {
            0% { background-color: #eaf2f8; }
            100% { background-color: inherit; }
        }

        .query-form {
            text-align: center;
            margin-bottom: 20px;
        }

        .query-input {
            width: 500px;
            padding: 5px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .submit-button {
            padding: 8px 12px;
            font-size: 14px;
            background-color: #4CAF50;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .submit-button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<div class="container">
    

    <?php
    $database = 'world';
    $connect = mysqli_connect(
        'db', # service name
        'root', # username
        'root', # password
        $database # db table
    );

    $table_name = "world_cities";
    echo "<h1>Database : `$database`</h1>";
    echo "<h4>Table : `$table_name`</h4>";
    $query = isset($_POST['query']) ? $_POST['query'] : "SELECT * FROM $table_name";

    if (isset($_POST['submit'])) {
        $response = mysqli_query($connect, $query);
    } else {
        $response = mysqli_query($connect, "SELECT * FROM $table_name");
    }

    echo "<table>";
    echo "<tr>";
    echo "<th>ID</th>";
    echo "<th>City</th>";
    echo "<th>Country Code</th>";
    echo "<th>Coordinate</th>";
    echo "</tr>";
    while ($row = mysqli_fetch_assoc($response)) {
        echo "<tr>";
        echo "<td>".$row['id']."</td>";
        echo "<td>".$row['name']."</td>";
        echo "<td>".$row['country_code']."</td>";
        echo "<td>(".round($row['latitude'],3).",".round($row['longitude'],3).")</td>";
        echo "</tr>";
    }
    echo "</table>";

    mysqli_close($connect);
    ?>

    <form class="query-form" method="POST" action="">
        <input class="query-input" type="text" name="query" value="<?php echo $query; ?>">
        <br>
        <input class="submit-button" type="submit" name="submit" value="Submit">
    </form>
</div>
</body>
</html>
