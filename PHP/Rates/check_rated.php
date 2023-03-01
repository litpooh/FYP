<?php

$db_server = "sophia.cs.hku.hk";
$db_user = "wkng2";
$db_pwd = "5gnZ1808";
$link = mysqli_connect($db_server, $db_user, $db_pwd, $db_user) or die(mysqli_error());

$action = (isset($_GET['action']) ? $_GET['action'] : "");

$email = (isset($_GET['email']) ? $_GET['email'] : "");
$cp_id = (isset($_GET['cp_id']) ? $_GET['cp_id'] : "");

if ($action == "check_rated") {
    
    $sql = "SELECT email, cp_id, score, dirty, full, transportation, wrong, impolite   FROM Rates WHERE email = '$email' AND cp_id = $cp_id" ;

    // Check if there are results
    if ($result = mysqli_query($link, $sql)) {
        // If so, then create a results array and a temporary one
        // to hold the data
        $resultArray = array();
        $tempArray = array();
    
        // Loop through each row in the result set
        while($row = $result->fetch_object()) {
            // Add each row into our results array
            $tempArray = $row;
            array_push($resultArray, $tempArray);
        }
    
        // Finally, encode the array to JSON and output the results
        echo json_encode($resultArray);
    }


}

