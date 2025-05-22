<?php
include("session_manager.php");
include("config.php");

// Checking to see if the user is logged in
if (!isset($_SESSION['valid'])) {
    header("Location: index.php");
    exit();
}


$officer_name = "Officer";
$officer_role = "User"; 
$officer_id = isset($_SESSION['officer_id']) ? $_SESSION['officer_id'] : "";

// ------------- Fetching the officer details from the database -------------//
if (!empty($officer_id)) {
    // --------------- Fetching  Officer Name and Role -----------------//
    $officerQuery = "SELECT Officer.Officer_Name, OfficerLogin.Officer_role 
              FROM Officer 
              JOIN OfficerLogin ON Officer.Officer_ID = OfficerLogin.Officer_ID 
              WHERE Officer.Officer_ID = ?";
    $statement = $con->prepare($officerQuery);
    $statement->bind_param("i", $officer_id);
    $statement->execute();
    $result = $statement->get_result();

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $officer_name = $row['Officer_Name'];
        $officer_role = $row['Officer_role'];
        // ------------- Set the role in the session -----------------//
        $_SESSION['role'] = $officer_role; 
    }
    $statement->close();
} else {
    // -------------- Redirecting to login if officer ID is missing --------------//
    header("Location: index.php");
    exit();
}

// ------------------ Add logic to identify if the user is an Administrator -----------------//
if ($officer_role === "Administrator") {
    $_SESSION['is_admin'] = true; 
} else {
    $_SESSION['is_admin'] = false;
}
?>