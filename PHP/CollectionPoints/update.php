<?php

$db_server = "sophia.cs.hku.hk";
$db_user = "wkng2";
$db_pwd = "5gnZ1808";
$link = mysqli_connect($db_server, $db_user, $db_pwd, $db_user) or die(mysqli_error());

$action = (isset($_GET['action']) ? $_GET['action'] : "");

$cp_id = (isset($_GET['cp_id']) ? $_GET['cp_id'] : "");
// $cp_state = (isset($_GET['cp_state']) ? $_GET['cp_state'] : "");
$cp_state = (isset($_GET['cp_state']) ? $_GET['cp_state'] : "Accepted");
$district_id = (isset($_GET['district_id']) ? $_GET['district_id'] : "");
$address_en = (isset($_GET['address_en']) ? $_GET['address_en'] : "");
$lat = (isset($_GET['lat']) ? $_GET['lat'] : "");
$lgt = (isset($_GET['lgt']) ? $_GET['lgt'] : "");
$waste_type = (isset($_GET['waste_type']) ? $_GET['waste_type'] : "");
$legend = (isset($_GET['legend']) ? $_GET['legend'] : "");
$accessibility_notes = (isset($_GET['accessibility_notes']) ? $_GET['accessibility_notes'] : "");
$contact_en = (isset($_GET['contact_en']) ? $_GET['contact_en'] : "");
$openhour_en = (isset($_GET['openhour_en']) ? $_GET['openhour_en'] : "");
$mon_start = (isset($_GET['mon_start']) ? $_GET['mon_start'] : "");
$mon_end = (isset($_GET['mon_end']) ? $_GET['mon_end'] : "");
$tue_start = (isset($_GET['tue_start']) ? $_GET['tue_start'] : "");
$tue_end = (isset($_GET['tue_end']) ? $_GET['tue_end'] : "");
$wed_start = (isset($_GET['wed_start']) ? $_GET['wed_start'] : "");
$wed_end = (isset($_GET['wed_end']) ? $_GET['wed_end'] : "");
$thurs_start = (isset($_GET['thurs_start']) ? $_GET['thurs_start'] : "");
$thurs_end = (isset($_GET['thurs_end']) ? $_GET['thurs_end'] : "");
$fri_start = (isset($_GET['fri_start']) ? $_GET['fri_start'] : "");
$fri_end = (isset($_GET['fri_end']) ? $_GET['fri_end'] : "");
$sat_start = (isset($_GET['sat_start']) ? $_GET['sat_start'] : "");
$sat_end = (isset($_GET['sat_end']) ? $_GET['sat_end'] : "");
$sun_start = (isset($_GET['sun_start']) ? $_GET['sun_start'] : "");
$sun_end = (isset($_GET['sun_end']) ? $_GET['sun_end'] : "");

if ($action == "update") {
    $sql = "UPDATE CollectionPoints SET cp_state = '$cp_state', district_id = '$district_id', address_en = '$address_en', lat = '$lat', lgt = '$lgt', waste_type = '$waste_type', legend = '$legend', accessibility_notes = '$accessibility_notes', contact_en = '$contact_en', openhour_en = '$openhour_en', mon_start = '$mon_start', mon_end = '$mon_end', tue_start = '$tue_start', tue_end = '$tue_end', wed_start = '$wed_start', wed_end = '$wed_end', thurs_start = '$thurs_start', thurs_end = '$thurs_end', fri_start = '$fri_start', fri_end = '$fri_end', sat_start = '$sat_start', sat_end = '$sat_end', sun_start = '$sun_start', sun_end = '$sun_end' WHERE cp_id = $cp_id";

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