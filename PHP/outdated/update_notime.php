<?php

$db_server = "sophia.cs.hku.hk";
$db_user = "wkng2";
$db_pwd = "5gnZ1808";
$link = mysqli_connect($db_server, $db_user, $db_pwd, $db_user) or die(mysqli_error());

$action = (isset($_GET['action']) ? $_GET['action'] : "");

$cp_id = (isset($_GET['cp_id']) ? $_GET['cp_id'] : "");
$district_id = (isset($_GET['district_id']) ? $_GET['district_id'] : "");
$address_en = (isset($_GET['address_en']) ? $_GET['address_en'] : "");
$lat = (isset($_GET['lat']) ? $_GET['lat'] : "");
$lgt = (isset($_GET['lgt']) ? $_GET['lgt'] : "");
$waste_type = (isset($_GET['waste_type']) ? $_GET['waste_type'] : "");
$legend = (isset($_GET['legend']) ? $_GET['legend'] : "");
$accessibility_notes = (isset($_GET['accessibility_notes']) ? $_GET['accessibility_notes'] : "");
$contact_en = (isset($_GET['contact_en']) ? $_GET['contact_en'] : "");
$openhour_en = (isset($_GET['openhour_en']) ? $_GET['openhour_en'] : "");


if ($action == "update") {
    $sql = "UPDATE CollectionPoints SET district_id = '$district_id', address_en = '$address_en', lat = '$lat', lgt = '$lgt', waste_type = '$waste_type', legend = '$legend', accessibility_notes = '$accessibility_notes', contact_en = '$contact_en', openhour_en = '$openhour_en' WHERE cp_id = $cp_id";

    if(mysqli_query($link, $sql)){
        echo "Record was updated successfully.";

        $sql_check = "SELECT * FROM CollectionPoints WHERE cp_id = $cp_id";
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