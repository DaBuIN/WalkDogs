<?php
include  "sqlPdo3.php";

$PDO = new PDO($dsn,$username,$passwd,$options);

//取得account
if (isset($_REQUEST['account'])){

    $account = $_REQUEST['account'];


    //檢查帳號是否重複

    $sqlacccheck = "SELECT COUNT(account) FROM dogmember WHERE account = ?";

    $stmtacccheck = $PDO->prepare($sqlacccheck);
    $stmtacccheck->execute([$account]);




    //方法一
//    $rs = $stmtacccheck->fetchColumn();
//
//    echo $rs;

    //方法二
     $rs = $stmtacccheck->fetch();


    $rowcount = $rs[0];

    if ($rowcount < 1) {
        //  帳號不存在 則可新增帳號
//        echo "gotoadd";
        echo "accountok";

        $passwd= $_REQUEST['passwd'];
        $mastername = $_REQUEST['mastername'];
//    $pic = $_REQUEST['pic'];
        $timezone = date_default_timezone_set("Asia/Taipei");
        $createtime = date("Y-m-d H:i:s");


        //insert 資料進dogmember
        $sql = "INSERT INTO dogmember(account,passwd,mastername,createdate) VALUES (?,?,?,?)";

        $stmt = $PDO->prepare($sql);

        $stmt->execute([$account,$passwd,$mastername,$createtime]);

        //馬上查詢 account的id多少
        $sqlgetid = "SELECT id FROM dogmember where account = ?";

        $stmt2 = $PDO->prepare($sqlgetid);

        $stmt2->execute([$account]);

        $rs = $stmt2->fetchObject();
//        echo  $rs->id;


        //令$mid = account的id
        $mid = $rs->id;




        //將$mid  insert進去dog 資料表
        // $sqltodogs = "INSERT INTO dogs (mid,createdate) VALUES (?,?)";
        // $stmt3 = $PDO->prepare($sqltodogs);

        // $stmt3->execute([$mid,$createtime]);




//        echo "OK";

    }else {



        echo  "accountexist";





    }













//


}

