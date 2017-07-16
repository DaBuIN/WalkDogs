<?php

// $host = '127.0.0.1';
// $db = 'seven';
// $username = 'root';
// $passwd = 'root';
// $driver = 'mysql';
// $charset = 'utf8';

// $dsn = "{$driver}:host={$host};dbname={$db};charset={$charset}";

// $options = [PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_BOTH];






$host = '127.0.0.1';
$db = 'c9';
$username = 'root';
$passwd = '';
$driver = 'mysql';
$charset = 'utf8';

$dsn = "{$driver}:host={$host};dbname={$db};charset={$charset}";

$options = [PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_BOTH];




//  $dbname = 'c9';
// $ip = getenv('IP');
// $user = getenv('C9_USER');

//     // $connection = mysqli_connect($host, $user, $pass, $db, $port)or die(mysql_error());

//     $PDO = new PDO("mysql:host=$ip;port=$port;dbname=$db;charset=utf8",$user,"");


//     $sql = "SELECT * FROM dogmember";
//     $stmt = $PDO->prepare();
//     $stmt->excecute;






// echo "good";




//  $query = "SELECT * FROM dogmember";
//     $result = mysqli_query($connection, $query);

//     while ($row = mysqli_fetch_assoc($result)) {
//         echo "The ID is: " . $row['id'] . " and the Username is: " . $row['account'];
//     }