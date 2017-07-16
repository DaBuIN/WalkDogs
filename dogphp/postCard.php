<?php
include  "sqlPdo3.php";

$PDO = new PDO($dsn,$username,$passwd,$options);


if (isset($_REQUEST['doing'],$_REQUEST['account'])){

    $account = $_REQUEST['account'];
    $doing = $_REQUEST['doing'];
    $lat  = $_REQUEST['lat'];
    $lng = $_REQUEST['lng'];
    //path
    $docpic = $_REQUEST['dogpic'];

    
    // echo $account;
    // echo "<br>";
    // echo $doing;
    // echo "<br>";
    // echo $lat;
    // echo "<br>";
    // echo $lng;
    
    
//    $doing = $_REQUEST['doing'];

//    $mastername = $_REQUEST['mastername'];

//先查詢 mastername

  $sql2  = "SELECT id FROM dogmember where account = ?";
    $stmt2 = $PDO->prepare($sql2);
    $stmt2->execute([$account]);


    $rs = $stmt2->fetchObject();

//    var_dump($rs);

    $mid =  $rs->id;


    // echo $account;
    // echo "<br>";
    // echo $doing;
    // echo "<br>";
    // echo $lat;
    // echo "<br>";
    // echo $lng;
    // echo "<br>";
    // echo $mid;
    
    

  

    $timezone = date_default_timezone_set("Asia/Taipei");
    $createtime = date("Y-m-d H:i:s");

    // $sqlinsert = "UPDATE SET doing = ? ,lat = ?,lng = ?, createdate = ?) FROM dogs where mid = ?";
    $sqlinsert = "INSERT INTO dogs (doing,lat,lng,createdate,mid,dogpic) VALUES (?,?,?,?,?,?)";


    $stmt = $PDO->prepare($sqlinsert);

    $stmt->execute([$doing,$lat,$lng,$createtime,$mid,$docpic]);

    echo "OK";

}