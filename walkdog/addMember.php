<?php
include  "sqlPdo3.php";

$PDO = new PDO($dsn,$username,$passwd,$options);


if (isset($_REQUEST['account'])){

    $account = $_REQUEST['account'];
    $passwd= $_REQUEST['passwd'];
    $mastername = $_REQUEST['mastername'];
//    $pic = $_REQUEST['pic'];
    $timezone = date_default_timezone_set("Asia/Taipei");
    $createtime = date("Y-m-d H:i:s");

    $sql = "INSERT INTO dogmember(account,passwd,mastername,createdate) VALUES (?,?,?,?)";

    $stmt = $PDO->prepare($sql);

    $stmt->execute([$account,$passwd,$mastername,$createtime]);

    echo "OK";

}

