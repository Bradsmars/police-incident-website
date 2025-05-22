<?php
include("php/header.php");
include("php/sidebar.php");
include("php/config.php");
include("php/Audit_logging.php");

?>

<!DOCTYPE html>
<html>
<head>
    <title>Add Vehicle</title>
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
<!-- Header -->
    <header class="w3-container">
        <div class="w3-row">
            <div class="w3-half">
                <h5><b><i class="fa fa-plus"></i> Update Existing Owner</b></h5>
            </div>
            <div class="w3-half w3-right-align">
                <a href="add_vehicle.php" class="w3-btn w3-blue">
                    <i class="fa fa-arrow-left"></i> Back </a>
            </div>
        </div>
    </header>


<!-- https://www.w3schools.com/css/tryit.asp?filename=trycss_forms -->
<!-- The form structures and styling for the 'Add New Vehicle' page were inspired by a W3Schools tutorial on form design.
The example was adapted to include project-specific input fields such as registration plate, make, model, and owner. 
Reference: W3Schools CSS Forms Example. -->

<!-- Vehicle Form -->
<div class="w3-container">
    <div class="w3-row-padding">
        <h3>Update Vehicle Ownership</h3>
        <form method="POST"onsubmit="return validateForm()">
            <!-- Search for Current Owner -->
            <label for="current_owner_licence">Current Owner Licence:</label>
            <input class="w3-input w3-border" type="text" id="current_owner_licence" name="current_owner_licence" placeholder="Enter Current Owner Licence" required>

            <label for="vehicle_plate">Vehicle Registration Plate:</label>
            <input class="w3-input w3-border" type="text" id="vehicle_plate" name="vehicle_plate" placeholder="Enter Vehicle Plate" required>

            <label for="new_owner_licence">New Owner Licence:</label>
            <input class="w3-input w3-border" type="text" id="new_owner_licence" name="new_owner_licence" placeholder="Enter New Owner Licence" required>


            <button class="w3-button w3-blue w3-margin-top" type="submit" name="update_owner">Update Ownership</button>
        </form>
    </div>
</div>

<!-- JS file -->
<script src="Js/scripts.js"></script>
</body>
</html>

<?php

function handleError($message) {
    echo "<div class='w3-container red-msg'><p>$message</p></div>";
    exit();
}

function handleSuccess($message) {
    echo "<div class='w3-container green-msg'><p>$message</p></div>";
    exit();
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['update_owner'])) {
    $ipAddress = $_SERVER['REMOTE_ADDR'];
    $officerId = $_SESSION['officer_id'] ?? handleError("Officer ID not found. Please log in again.");

    $currentOwnerLicence = isset($_POST['current_owner_licence']) ? trim($_POST['current_owner_licence']) : null;
    $vehiclePlate = isset($_POST['vehicle_plate']) ? trim($_POST['vehicle_plate']) : null;
    $newOwnerLicence = isset($_POST['new_owner_licence']) ? trim($_POST['new_owner_licence']) : null;

    // -------------------------------- Validating inputs ---------------------------------------//
    if (!$currentOwnerLicence || !$vehiclePlate || !$newOwnerLicence) {
        logAudit($con,$officerId,'Ownership',0,'UPDATE_FAILED','Attempted ownership update with missing fields','Missing required fields in ownership update form',$ipAddress
        );
        handleError("Error: All fields are required.");
    }

    // -------------------- Fetching Vehicle_ID for the given plate by user ----------------------//
    $fetchVehicleIdQuery = "SELECT Vehicle.Vehicle_ID 
                           FROM Vehicle 
                           WHERE Vehicle.Vehicle_plate = ?";
    $fetchVehicleIdStatement = $con->prepare($fetchVehicleIdQuery);
    $fetchVehicleIdStatement->bind_param("s", $vehiclePlate);
    $fetchVehicleIdStatement->execute();
    $fetchVehicleIdStatement->bind_result($vehicleId);
    $fetchVehicleIdStatement->fetch();
    $fetchVehicleIdStatement->close();

    if (!$vehicleId) {
        logAudit($con,$officerId,'Ownership',0,'UPDATE_FAILED',"Attempted to update ownership for non-existent vehicle","Vehicle plate not found: $vehiclePlate",
            $ipAddress);
        handleError("Error: Vehicle not found.");
    }

    // Checking the current ownership
    $checkCurrentOwnershipQuery = 
        "SELECT 
            Ownership.People_ID,
            People.People_name,
            Vehicle.Vehicle_plate,
            People.People_licence
         FROM Ownership
         INNER JOIN Vehicle ON Ownership.Vehicle_ID = Vehicle.Vehicle_ID
         INNER JOIN People ON Ownership.People_ID = People.People_ID
         WHERE Vehicle.Vehicle_plate = ? 
         AND People.People_licence = ?";

    $checkCurrentOwnershipStatement = $con->prepare($checkCurrentOwnershipQuery);
    $checkCurrentOwnershipStatement->bind_param("ss", $vehiclePlate, $currentOwnerLicence);
    $checkCurrentOwnershipStatement->execute();
    $result = $checkCurrentOwnershipStatement->get_result();
    $currentOwnerData = $result->fetch_assoc();
    $associatedOwnerId = $currentOwnerData['People_ID'] ?? null;
    $currentOwnerName = $currentOwnerData['People_name'] ?? 'Unknown';
    $checkCurrentOwnershipStatement->close();

    if (!$associatedOwnerId) {
        logAudit(
            $con,
            $officerId,
            'Ownership',
            $vehicleId,
            'UPDATE_FAILED',
            "Current owner verification failed",
            "Specified current owner not associated with vehicle: Plate $vehiclePlate, License $currentOwnerLicence",
            $ipAddress
        );
        handleError("Error: The current owner is not associated with the specified vehicle.");
    }

    // Fetch new owner details
    $fetchNewOwnerIdQuery = "SELECT People.People_ID, People.People_name 
                            FROM People 
                            WHERE People.People_licence = ?";
    $fetchNewOwnerIdStatement = $con->prepare($fetchNewOwnerIdQuery);
    $fetchNewOwnerIdStatement->bind_param("s", $newOwnerLicence);
    $fetchNewOwnerIdStatement->execute();
    $newOwnerResult = $fetchNewOwnerIdStatement->get_result();
    $newOwnerData = $newOwnerResult->fetch_assoc();
    $newOwnerId = $newOwnerData['People_ID'] ?? null;
    $newOwnerName = $newOwnerData['People_name'] ?? 'Unknown';
    $fetchNewOwnerIdStatement->close();

    if (!$newOwnerId) {
        logAudit($con,$officerId,'Ownership',$vehicleId,'UPDATE_FAILED',"New owner verification failed","New owner license not found: $newOwnerLicence",
            $ipAddress);
        handleError("Error: New owner not found.");
    }

    // Remove existing ownership
    $deleteOwnershipQuery = "DELETE FROM Ownership 
                            WHERE Ownership.Vehicle_ID = ?";
    $deleteOwnershipStatement = $con->prepare($deleteOwnershipQuery);
    $deleteOwnershipStatement->bind_param("i", $vehicleId);
    if (!$deleteOwnershipStatement->execute()) {
        logAudit($con,$officerId,'Ownership',$vehicleId,'UPDATE_FAILED',"Failed to remove existing ownership","Database error during ownership removal",
            $ipAddress);
        handleError("Error: Removing existing ownership failed.");
    }
    $deleteOwnershipStatement->close();

    // Add new ownership
    $addOwnershipQuery = "INSERT INTO Ownership (Ownership.People_ID, Ownership.Vehicle_ID) 
                         VALUES (?, ?)";
    $addOwnershipStatement = $con->prepare($addOwnershipQuery);
    $addOwnershipStatement->bind_param("ii", $newOwnerId, $vehicleId);
    
    if ($addOwnershipStatement->execute()) {
        // Log the successful ownership change
        $changes = "Previous Owner Details:\n" .
                  "Name: $currentOwnerName\n" .
                  "License: $currentOwnerLicence\n" .
                  "Vehicle Plate: $vehiclePlate\n" .
                  "Vehicle ID: $vehicleId";
                  
        $beforeChanges = "New Owner Details:\n" .
                        "Name: $newOwnerName\n" .
                        "License: $newOwnerLicence\n" .
                        "Vehicle Plate: $vehiclePlate\n" .
                        "Vehicle ID: $vehicleId";

        logAudit($con,$officerId,'Ownership',$vehicleId,'UPDATE',$changes,$beforeChanges,$ipAddress);
        handleSuccess("Ownership updated. Vehicle has been reassigned to the new owner.");
    } else {
        logAudit($con,$officerId,'Ownership',$vehicleId,'UPDATE_FAILED',"Failed to add new ownership",
            "Error: " . $addOwnershipStatement->error,
            $ipAddress);
        handleError("Error updating ownership: " . htmlspecialchars($addOwnershipStatement->error));
    }
    $addOwnershipStatement->close();
}
?>






