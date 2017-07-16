<?php

include "sqlPdo3.php";

$PDO = new PDO($dsn,$username,$passwd,$options);

$account = $_REQUEST['account'];


// $sql = "SELECT * FROM dogs ORDER BY id DESC ";

//join
$sql = "SELECT dogs.id, dogs.mid, dogmember.mastername ,dogs.doing,dogs.createdate, dogs.lat, dogs.lng,dogs.dogpic FROM dogmember JOIN dogs  ON dogmember.id = dogs.mid ORDER BY dogs.createdate DESC ";

//select * from product as o INNER JOIN orders as p on o.pid=p.pid


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
