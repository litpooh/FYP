<?php


// return collection points if correct, else empty
// BACKUP: search_time_norates.php in outdated folder


$db_server = "sophia.cs.hku.hk";
$db_user = "wkng2";
$db_pwd = "5gnZ1808";
$link = mysqli_connect($db_server, $db_user, $db_pwd, $db_user) or die(mysqli_error());

$action = (isset($_GET['action']) ? $_GET['action'] : "");
// echo($action);
$waste_type = (isset($_GET['waste_type']) ? $_GET['waste_type'] : "");
// echo($waste_type);

// Delimit by COMMA
$parts = explode(',', $waste_type);

$likes = array();
foreach($parts as $part) {
   $likes[] = "waste_type LIKE '%$part%'";
}

//if ($action == "search_timeandrates")
if ($action == "search_types") {
    
    //$sql = " SELECT C.cp_id, C.district_id, C.address_en, C.lat, C.lgt, C.waste_type, C.legend, C.accessibility_notes, C.contact_en, C.openhour_en, C.mon_start, C.mon_end, C.tue_start, C.tue_end, C.wed_start, C.wed_end, C.thurs_start, C.thurs_end, C.fri_start, C.fri_end, C.sat_start, C.sat_end, C.sun_start, C.sun_end, COUNT(R.dirty), COUNT(R.full), COUNT(R.transportation), COUNT(R.wrong), COUNT(R.impolite) FROM CollectionPoints C, Rates R WHERE C.cp_id = R.cp_id AND C.cp_id IN (SELECT cp_id  FROM CollectionPoints WHERE "  . implode(' AND ', $likes) . ") GROUP BY R.cp_id";

    $sql_original = "SELECT cp_id, district_id, address_en, lat, lgt, waste_type, legend, accessibility_notes, contact_en, openhour_en, mon_start, mon_end, tue_start, tue_end, wed_start, wed_end, thurs_start, thurs_end, fri_start, fri_end, sat_start, sat_end, sun_start, sun_end   FROM CollectionPoints WHERE "  . implode(' AND ', $likes);
    $sql_points = "SELECT cp_id, district_id, address_en, lat, lgt, waste_type, legend, accessibility_notes, contact_en, openhour_en, mon_start, mon_end, tue_start, tue_end, wed_start, wed_end, thurs_start, thurs_end, fri_start, fri_end, sat_start, sat_end, sun_start, sun_end   FROM CollectionPoints WHERE "  . implode(' AND ', $likes);
    $sql_rates = "SELECT cp_id, SUM(dirty) AS dirty_num, SUM(full) AS full_num, SUM(transportation) AS transportation_num, SUM(wrong) AS wrong_num, SUM(impolite) AS impolite_num FROM Rates GROUP BY cp_id";

    $sql = "SELECT C.cp_id, C.district_id, C.address_en, C.lat, C.lgt, C.waste_type, C.legend, C.accessibility_notes, C.contact_en, C.openhour_en, C.mon_start, C.mon_end, C.tue_start, C.tue_end, C.wed_start, C.wed_end, C.thurs_start, C.thurs_end, C.fri_start, C.fri_end, C.sat_start, C.sat_end, C.sun_start, C.sun_end, IFNULL(R.dirty_num,0) AS dirty_num, IFNULL(R.full_num,0) AS full_num, IFNULL(R.transportation_num,0) AS transportation_num, IFNULL(R.wrong_num,0) AS wrong_num, IFNULL(R.impolite_num,0) AS impolite_num FROM (" . $sql_points . ") AS C LEFT OUTER JOIN (" . $sql_rates . ") AS R ON C.cp_id = R.cp_id";
    //echo @sql

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
    


?>