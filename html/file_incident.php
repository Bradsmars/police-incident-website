<?php
include("php/header.php");
include("php/sidebar.php");
include("php/config.php");
include("php/Audit_logging.php");

set_exception_handler(function ($e) {
    $Message = "Something went wrong !! !";
    echo "<div class='w3-container red-msg'><p>$Message " . htmlspecialchars($e->getMessage()) . "</p></div>";
    error_log($e->getMessage()); 
    exit;
});

?>

<!DOCTYPE html>
<html>
<head>
    <title>File Incident</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="style/pages.css">
</head>
<body class="w3-light-grey">

<!-- Overlay effect for small screens -->
<div class="w3-overlay w3-hide-large" onclick="w3_close()" id="myOverlay"></div>

<!-- Page content -->
<div class="w3-main">
    <!-- Header -->
    <header class="w3-container">
        <h5><b><i class="fa fa-plus"></i> File Incident</b></h5>
    </header>

    
    <div class="w3-container">
    <form method="POST" action="" onsubmit="return validateFileIncidentForm()">
        <h3>File New Incident</h3>
        
       
        <label for="incident_report">Incident Report:</label>
        <textarea id="incident_report" name="incident_report" class="w3-input w3-border" rows="4" required></textarea>

        <label for="offence_id">Offence Type:</label>
        <select id="offence_id" name="offence_id" class="w3-select w3-border" required>
            <option value="">Select Offence</option>
            <?php
            // Fetch offence types from the database in alphabetical order
            $offence_query = "SELECT Offence_ID, Offence_description FROM Offence ORDER BY Offence_description ASC";
            $result = $con->query($offence_query);
            while ($row = $result->fetch_assoc()) {
                echo "<option value='{$row['Offence_ID']}'>" . htmlspecialchars($row['Offence_description']) . "</option>";
            }
            ?>
        </select>

        <!-- Date of Incident -->
        <label for="incident_date">Date of Incident:</label>
        <input type="date" id="incident_date" name="incident_date" class="w3-input w3-border" required>
        
        <!-- Time of Incident -->
        <label for="incident_time">Time of Incident:</label>
        <input type="time" id="incident_time" name="incident_time" class="w3-input w3-border" required>

        <!-- Vehicle Association -->
        <h4>Associate Vehicle (Optional)</h4>
        <label for="vehicle_id">Select Vehicle:</label>
        <select id="vehicle_id" name="vehicle_id" class="w3-select w3-border">
            <option value="">None</option>
            <?php
            // Fetching the existing vehicles from the database in alphabetical order
            $vehicle_query = "SELECT Vehicle_ID, Vehicle_plate FROM Vehicle ORDER BY Vehicle_plate ASC";
            $result = $con->query($vehicle_query);
            while ($row = $result->fetch_assoc()) {
                echo "<option value='{$row['Vehicle_ID']}'>" . htmlspecialchars($row['Vehicle_plate']) . "</option>";
            }
            ?>
        </select>

        <!-------------------  Associating the  Person Using License ---------------------->
        <h4>Associate Person by License (Required)</h4>
        <label for="person_licence">Person License:</label>
        <input type="text" id="person_licence" name="person_licence" class="w3-input w3-border" placeholder="Enter Person License" required>



        <!-------------------------- Role Association  -------------------------->
        <h4>Specify Role</h4>
        <label for="role">Role:</label>
        <input type="text" id="role" name="role" class="w3-input w3-border" placeholder="Enter role (e.g. Driver, Passenger, Witness)" required>


      
        <button type="submit" name="file_incident" class="w3-button w3-green w3-margin-top">File Incident</button>
    </form>
</div>


<?php

// ----------- Helper function for error handling ------------ //
function handleError($message) {
    echo "<div class='w3-container red-msg'><p>$message</p></div>";
    exit();
}

//--------------- Helper function for success messages ---------------//
function handleSuccess($message) {
    echo "<div class='w3-container green-msg'><p>$message</p></div>";
    exit();
}

//--------- Helper function for warning messages ------------//
function YellowMsg($message) {
    echo "<div class='w3-container yellow-msg'><p>$message</p></div>";
    exit();
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['file_incident'])) {
    $ipAddress = $_SERVER['REMOTE_ADDR'];
    $officerId = $_SESSION['officer_id'] ?? handleError("Officer ID not found. Please log in again.");

    // ------------------ Adding new incident to the database ----------------- //
    $incident_report = mysqli_real_escape_string($con, $_POST['incident_report']);
    $offence_id = $_POST['offence_id'];
    $incident_date = $_POST['incident_date'];
    $incident_time = $_POST['incident_time'];
    $vehicle_id = !empty($_POST['vehicle_id']) ? $_POST['vehicle_id'] : null;
    $role = mysqli_real_escape_string($con, $_POST['role']);

    // ----------- Getting the offence description for audit log ---------------- //
    $offenceQuery = "SELECT Offence_description FROM Offence WHERE Offence_ID = ?";
    $offenceStmt = $con->prepare($offenceQuery);
    $offenceStmt->bind_param("i", $offence_id);
    $offenceStmt->execute();
    $offenceResult = $offenceStmt->get_result();
    $offenceData = $offenceResult->fetch_assoc();
    $offence_description = $offenceData['Offence_description'] ?? 'Unknown';
    $offenceStmt->close();

    // -------- Getting the vehicle plate for audit log if vehicle_id exists ------------ //
    $vehicle_plate = 'None';
    if ($vehicle_id) {
        $vehicleQuery = "SELECT Vehicle_plate FROM Vehicle WHERE Vehicle_ID = ?";
        $vehicleStmt = $con->prepare($vehicleQuery);
        $vehicleStmt->bind_param("i", $vehicle_id);
        $vehicleStmt->execute();
        $vehicleResult = $vehicleStmt->get_result();
        $vehicleData = $vehicleResult->fetch_assoc();
        $vehicle_plate = $vehicleData['Vehicle_plate'] ?? 'Unknown';
        $vehicleStmt->close();
    }

    // ------------------ Validating person license ------------------- //
    if (!empty($_POST['person_licence'])) {
        $person_licence = mysqli_real_escape_string($con, $_POST['person_licence']);
        $person_query = "SELECT People_ID, People_name FROM People WHERE People_licence = ?";
        $person_statement = $con->prepare($person_query);
        $person_statement->bind_param("s", $person_licence);
        $person_statement->execute();
        $personResult = $person_statement->get_result();
        $personData = $personResult->fetch_assoc();
        $person_id = $personData['People_ID'] ?? null;
        $person_name = $personData['People_name'] ?? 'Unknown';
        $person_statement->close();

        if (empty($person_id)) {
            logAudit($con,$officerId,'Incident',0,'CREATE_FAILED',"Attempted to create incident with invalid license","Invalid license number: $person_licence",$ipAddress);
            handleError("No person found with the provided license.");
        }
    } else {
        logAudit($con,$officerId,'Incident',0,'CREATE_FAILED',"Attempted to create incident without license","Missing person license",$ipAddress);
        YellowMsg("You must provide a valid person license.");
    }

    // ------------------------------------------ Inserting incident details -------------------------------------------------- //
    $query = "INSERT INTO Incident (Incident_Report, Offence_ID, Incident_Date, Incident_Time, Vehicle_ID, People_ID, Officer_ID, Role) 
              VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    $incident_statement = $con->prepare($query);
    $incident_statement->bind_param("sissiiis", $incident_report, $offence_id, $incident_date, $incident_time, $vehicle_id, $person_id, $officerId, $role);

    if ($incident_statement->execute()) {
        $new_incident_id = $incident_statement->insert_id;
        
    //------- Preparing my audit message ------------//
        $changes = "New Incident Created:\n" .
                  "Report: $incident_report\n" .
                  "Date: $incident_date\n" .
                  "Time: $incident_time\n" .
                  "Offence: $offence_description\n" .
                  "Vehicle: $vehicle_plate\n" .
                  "Person License: $person_licence\n" .
                  "Person Name: $person_name\n" .
                  "Role: $role";

        logAudit($con,$officerId,'Incident',$new_incident_id,'CREATE','New incident filed',$changes,$ipAddress);
        
        handleSuccess("Incident filed successfully!");
    } else {logAudit($con,$officerId,'Incident',0,'CREATE_FAILED',"Failed to create incident","Error: " . $incident_statement->error,$ipAddress);
        handleError("Error filing incident: " . htmlspecialchars($incident_statement->error));
    }
    $incident_statement->close();
}
?>

<!-- JS file -->
<script src="Js/scripts.js"></script>
</body>
</html>


  
