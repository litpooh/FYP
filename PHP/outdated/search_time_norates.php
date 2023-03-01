<?php


// return collection points if correct, else empty


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

if ($action == "search") {
    
    $sql = "SELECT cp_id, district_id, address_en, lat, lgt, waste_type, legend, accessibility_notes, contact_en, openhour_en, mon_start, mon_end, tue_start, tue_end, wed_start, wed_end, thurs_start, thurs_end, fri_start, fri_end, sat_start, sat_end, sun_start, sun_end   FROM CollectionPoints WHERE "  . implode(' AND ', $likes);

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