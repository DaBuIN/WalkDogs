<?php

include "sqlPdo3.php";

$PDO = new PDO($dsn,$username,$passwd,$options);

$account = $_REQUEST['account'];


$sql = "SELECT account,doing,lat,lng FROM dogs ORDER BY id DESC ";
$stmt = $PDO->prepare($sql);
$stmt->execute();

$rs = $stmt->fetchAll(PDO::FETCH_ASSOC);


//echo $rs->mastername;
$json=json_encode($rs);

echo  $json;
//var_dump($json);

//var_dump($stmt);

//var_dump($rs);

//$rs = $stmt->fetchALL(PDO::FETCH_ASSOC);
//
//var_dump($rs);
//
//while ($rs = $stmt->fetchObject() ){
//
//    echo "\"". $rs->mastername."\"" . ",";
//    echo "<br>";
//}
