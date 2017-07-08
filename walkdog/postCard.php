<?php
include  "sqlPdo3.php";

$PDO = new PDO($dsn,$username,$passwd,$options);


if (isset($_REQUEST['doing'])){

    $account = $_REQUEST['account'];
    $doing = $_REQUEST['doing'];
    $lat  = $_REQUEST['lat'];
    $lng = $_REQUEST['lng'];
//    $doing = $_REQUEST['doing'];

//    $mastername = $_REQUEST['mastername'];
//    $pic = $_REQUEST['pic'];
    $timezone = date_default_timezone_set("Asia/Taipei");
    $createtime = date("Y-m-d H:i:s");

    $sql = "INSERT INTO dogs(account,doing,lat,lng,createdate) VALUES (?,?,?,?,?)";

    $stmt = $PDO->prepare($sql);

    $stmt->execute([$account,$doing,$lat,$lng,$createtime]);

    echo "OK";

}