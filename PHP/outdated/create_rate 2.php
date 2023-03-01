<?php

$db_server = "sophia.cs.hku.hk";
$db_user = "wkng2";
$db_pwd = "5gnZ1808";
$link = mysqli_connect($db_server, $db_user, $db_pwd, $db_user) or die(mysqli_error());

$action = (isset($_GET['action']) ? $_GET['action'] : "");

$email = (isset($_GET['email']) ? $_GET['email'] : "");
$cp_id = (isset($_GET['cp_id']) ? $_GET['cp_id'] : "");
$dirty = (isset($_GET['dirty']) ? $_GET['dirty'] : "");
$full = (isset($_GET['full']) ? $_GET['full'] : "");
$transportation = (isset($_GET['transportation']) ? $_GET['transportation'] : "");
$wrong = (isset($_GET['wrong']) ? $_GET['wrong'] : "");
$impolite = (isset($_GET['impolite']) ? $_GET['impolite'] : "");

if ($action == "create_rate") {
    $sql = "INSERT INTO Rates (email, cp_id, dirty, full, transportation, wrong, impolite) VALUES ('$email', $cp_id, $dirty, $full, $transportation, $wrong, $impolite)";

    if(mysqli_query($link, $sql)){
        echo "Rate is created MYSQL successfully.";
    } else {
        echo "ERROR: Could not able to execute $sql. " 
                                . mysqli_error($link);
    } 

    mysqli_close($link);
}

?>