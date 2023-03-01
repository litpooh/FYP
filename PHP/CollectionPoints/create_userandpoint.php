<?php

$db_server = "sophia.cs.hku.hk";
$db_user = "wkng2";
$db_pwd = "5gnZ1808";
$link = mysqli_connect($db_server, $db_user, $db_pwd, $db_user) or die(mysqli_error());

$action = (isset($_GET['action']) ? $_GET['action'] : "");

$email = (isset($_GET['email']) ? $_GET['email'] : "");
// $cp_id = (isset($_GET['cp_id']) ? $_GET['cp_id'] : "");
$cp_state = (isset($_GET['cp_state']) ? $_GET['cp_state'] : "Accepted");
$district_id = (isset($_GET['district_id']) ? $_GET['district_id'] : "");
$address_en = (isset($_GET['address_en']) ? $_GET['address_en'] : "");
$address2_en = "";
$address_tc = "";
$address2_tc = "";
$address_sc = "";
$address2_sc = "";
$lat = (isset($_GET['lat']) ? $_GET['lat'] : "");
$lgt = (isset($_GET['lgt']) ? $_GET['lgt'] : "");
$waste_type = (isset($_GET['waste_type']) ? $_GET['waste_type'] : "");
$legend = (isset($_GET['legend']) ? $_GET['legend'] : "");
$accessibility_notes = (isset($_GET['accessibility_notes']) ? $_GET['accessibility_notes'] : "");
$contact_en = (isset($_GET['contact_en']) ? $_GET['contact_en'] : "");
$contact_tc = "";
$contact_sc = "";
$openhour_en = (isset($_GET['openhour_en']) ? $_GET['openhour_en'] : "");
$openhour_tc = "";
$openhour_sc = "";

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

if ($action == "create_userandpoint") {
    // calculate the cp_id for the newly created collection point
    $sql_get_cpid = "SELECT MAX(cp_id) AS total FROM CollectionPoints";
    $result_get_cpid = mysqli_query($link, $sql_get_cpid);
    $data = mysqli_fetch_assoc($result_get_cpid);
    $total = $data['total'];
    //echo "CP_id: $total";

    $cp_id = ((int)$total)+1;

    $sql_link = "INSERT INTO Users (email, cp_id) VALUES ('$email', $cp_id)";

    if(mysqli_query($link, $sql_link)){
        echo "User and point are linked and recorded into MYSQL successfully.\n";
    } else {
        echo "ERROR: Could not able to execute $sql_link. " 
                                . mysqli_error($link);
    } 

    // Error occurs
    // Need to add back address2, xxx_sc...

    $sql_create = "INSERT INTO CollectionPoints (cp_id, cp_state, district_id, address_en, address2_en, address_tc, address2_tc, address_sc, address2_sc, lat, lgt, waste_type, legend, accessibility_notes, contact_en, contact_tc, contact_sc, openhour_en, openhour_tc, openhour_sc, mon_start, mon_end, tue_start, tue_end, wed_start, wed_end, thurs_start, thurs_end, fri_start, fri_end, sat_start, sat_end, sun_start, sun_end) VALUES ($cp_id, '$cp_state', '$district_id', '$address_en', '$address2_en', '$address_tc', '$address2_tc', '$address_sc', '$address2_sc', '$lat', '$lgt', '$waste_type', '$legend', '$accessibility_notes', '$contact_en', '$contact_tc', '$contact_sc', '$openhour_en', '$openhour_tc', '$openhour_sc', '$mon_start', '$mon_end', '$tue_start', '$tue_end', '$wed_start', '$wed_end', '$thurs_start', '$thurs_end', '$fri_start', '$fri_end', '$sat_start', '$sat_end', '$sun_start', '$sun_end')";
    if(mysqli_query($link, $sql_create)){
        echo "Point is created MYSQL successfully.\n";
        echo "CP_id: $cp_id";
    } else {
        echo "ERROR: Could not able to execute $sql_create. " 
                                . mysqli_error($link);
    } 

    mysqli_close($link);
    
}
