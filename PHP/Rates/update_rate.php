<?php

$db_server = "sophia.cs.hku.hk";
$db_user = "wkng2";
$db_pwd = "5gnZ1808";
$link = mysqli_connect($db_server, $db_user, $db_pwd, $db_user) or die(mysqli_error());

$action = (isset($_GET['action']) ? $_GET['action'] : "");

$email = (isset($_GET['email']) ? $_GET['email'] : "");
$cp_id = (isset($_GET['cp_id']) ? $_GET['cp_id'] : "");
$score = (isset($_GET['score']) ? $_GET['score'] : "");
$dirty = (isset($_GET['dirty']) ? $_GET['dirty'] : "");
$full = (isset($_GET['full']) ? $_GET['full'] : "");
$transportation = (isset($_GET['transportation']) ? $_GET['transportation'] : "");
$wrong = (isset($_GET['wrong']) ? $_GET['wrong'] : "");
$impolite = (isset($_GET['impolite']) ? $_GET['impolite'] : "");

if ($action == "update_rate") {
    $sql = "UPDATE Rates SET score=$score, dirty=$dirty, full=$full, transportation=$transportation, wrong=$wrong, impolite=$impolite WHERE email = '$email' AND cp_id = $cp_id";

    if(mysqli_query($link, $sql)){
        echo "Rate is updated in MYSQL successfully.";

        $sql_check = "SELECT * FROM Rates WHERE email = '$email' AND cp_id = $cp_id";
        $res_check = mysqli_query($link, $sql_check) or die(mysqli_error());
        while ($row = mysql_fetch_array($result_check)) {
            foreach($row as $key => $var) {
                echo $key . ' = ' . $var . '<br />';
            }                      
        }

    } else {
        echo "ERROR: Could not able to execute $sql. " 
                                . mysqli_error($link);
    } 

    mysqli_close($link);
}

?>