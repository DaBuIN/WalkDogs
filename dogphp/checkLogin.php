<?php

include "sqlPdo3.php";

$PDO = new PDO($dsn,$username,$passwd,$options);

$account = $_REQUEST['account'];
$passwd = $_REQUEST['passwd'];
//$id = $_REQUEST['id'];

$sql = "SELECT account,passwd FROM dogmember WHERE account = ?";
$stmt = $PDO->prepare($sql);
 $stmt->execute(["$account"]);

// echo $passwd;
//$rs = $stmt->fetchObject();


// 如果excute 出來 rowcount >1 表示比對帳號成功
if ($stmt->rowCount()>0){
//   echo "rowcoung:" . $stmt->rowCount();
   //提取ＤＢ物件的密碼
    $rs = $stmt->fetchObject();
    $dbpasswd = $rs->passwd;

    //如果輸入密碼與ＤＢ密馬一樣 則通過
    if ($passwd == $dbpasswd) {
//        echo "passwd right" . $passwd .":" . $dbpasswd;

        echo 'pass';

        $sql = "SELECT mid FROM dogmember WHERE account = ?";
        $stmt = $PDO->prepare($sql);
        $stmt->execute(["$account"]);



    }else {
        //密碼錯誤
//        echo "passwd wrong";
        echo 'passwdwrong';
    }



}else {
    //帳號不存在
//    echo "rowcount:" . $stmt->rowCount();
    echo 'accountwrong';
}






