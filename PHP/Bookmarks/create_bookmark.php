<?php

$db_server = "sophia.cs.hku.hk";
$db_user = "wkng2";
$db_pwd = "5gnZ1808";
$link = mysqli_connect($db_server, $db_user, $db_pwd, $db_user) or die(mysqli_error());

$action = (isset($_GET['action']) ? $_GET['action'] : "");

$email = (isset($_GET['email']) ? $_GET['email'] : "");
$cp_id = (isset($_GET['cp_id']) ? $_GET['cp_id'] : "");

if ($action == "create_bookmark") {
    $sql = "INSERT INTO Bookmarks (email, cp_id) VALUES ('$email', $cp_id)";

    if(mysqli_query($link, $sql)){
        echo "Bookmark is created in MYSQL successfully.";
    } else {
        echo "ERROR: Could not able to execute $sql. " 
                                . mysqli_error($link);
    } 

    mysqli_close($link);
}

?>