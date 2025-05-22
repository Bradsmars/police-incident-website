<?php
include("php/header.php");
include("php/sidebar.php");
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


<div class="w3-overlay w3-hide-large" onclick="w3_close()" id="myOverlay"></div>

<!-- Page content -->
<div class="w3-main">
    <!-- Header -->
<!-- Header -->
    <header class="w3-container">
        <div class="w3-row">
            <div class="w3-half">
                <h5><b><i class="fa fa-plus"></i> Add Vehicle</b></h5>
            </div>
            <div class="w3-half w3-right-align">
                <a href="update_owner.php" class="w3-btn w3-blue">
                    <i class="fa fa-edit"></i> Update Existing owner </a>
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
            <h3>Add New Vehicle Into System / (Associate Multiple Owners with Vehicle) Option</h3>
            <form method="POST" onsubmit="return validateAddVehicalForm()">
                <label for="vehicle_plate">Registration Plate:</label>
                <input class="w3-input w3-border" type="text" id="vehicle_plate" name="vehicle_plate" required>

                <label for="vehicle_make">Make:</label>
                <input class="w3-input w3-border" type="text" id="vehicle_make" name="vehicle_make" required>

                <label for="vehicle_model">Model:</label>
                <input class="w3-input w3-border" type="text" id="vehicle_model" name="vehicle_model" required>

                <label for="vehicle_colour">Colour:</label>
                <input class="w3-input w3-border" type="text" id="vehicle_colour" name="vehicle_colour" required>

                <label for="owner_id">Existing Owner:</label>
                <select class="w3-select w3-border" id="owner_id" name="owner_id">
                    <option value="">None</option>

                    <?php
                    // ----------------------------- Fetching existing owners from the database -----------------------------//
                    $result = $con->query("SELECT People_ID, People_name FROM People");
                    while ($row = $result->fetch_assoc()) {
                        echo "<option value='" . $row['People_ID'] . "'>" . htmlspecialchars($row['People_name']) . "</option>";
                    }
                    ?>

                </select>
                <button class="w3-button w3-blue w3-margin-top" type="submit" name="add_vehicle">Add Vehicle</button>
            </form>
        </div>
    </div>

    <!-- ------------------------Owner Form -->
    <div class="w3-container">
        <div class="w3-row-padding">
                <h3>Add New Person Into System</h3>
                <form method="POST"onsubmit="return validateAddPersonForm()">
                    <label for="owner_name">Name:</label>
                    <input class="w3-input w3-border" type="text" id="owner_name" name="owner_name" required>

                    <label for="owner_licence">License Number:</label>
                    <input class="w3-input w3-border" type="text" id="owner_licence" name="owner_licence" required>

                    <label for="owner_address">Address:</label>
                    <input class="w3-input w3-border" type="text" id="owner_address" name="owner_address" required>

                    <button class="w3-button w3-blue w3-margin-top" type="submit" name="add_owner">Add Owner</button>
                </form>
            </div>
        </div>
    </div>

 

</body>
</html>

<?php
include("php/config.php");
include("php/Audit_logging.php");

// ---------------- Helper function for error handling ----------------//
function handleError($message) {
    echo "<div class='w3-container red-msg'><p>$message</p></div>";
    exit();
}

// --------------- Helper function for success messages ---------------//
function handleSuccess($message) {
    echo "<div class='w3-container green-msg'><p>$message</p></div>";
    exit();
}

// ----------- Helper function for warning messages ------------------//
function YellowMsg($message) {
    echo "<div class='w3-container yellow-msg'><p>$message</p></div>";
}
//----------------------------------------------------------------------//

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get the officer ID from session i had troubles with this
    $officerId = $_SESSION['officer_id'] ?? 1; // Default to 1 just in case
    $ipAddress = $_SERVER['REMOTE_ADDR'];

    // ----------------- Add Owner/Person ----------------- //
    if (isset($_POST['add_owner'])) {
    //-----------------------------------------------------//
    //-----------------------------------------------------//
        // Fetching the  form values
        $ownerName = trim($_POST['owner_name']);
        $ownerLicenseNumber = trim($_POST['owner_licence']);
        $ownerAddress = trim($_POST['owner_address']);

    // -------------------- Validate inputs ------------------- --------------------------//
        if (!empty($ownerName) && !empty($ownerLicenseNumber) && !empty($ownerAddress)) {
            // Checking to see if the license number already exists in the database
            $checkLicenseQuery = "SELECT People_licence FROM People WHERE People_licence = ?";
            $licenseCheckStmt = $con->prepare($checkLicenseQuery);
            $licenseCheckStmt->bind_param("s", $ownerLicenseNumber);
            $licenseCheckStmt->execute();
            $licenseCheckStmt->store_result();

            if ($licenseCheckStmt->num_rows > 0) {
                // duplicated entry 
                logAudit($con,$officerId,'People',
                    0, 
                    'CREATE_FAILED',
                    'Attempted to create new person',
                    "Failed: License number already exists: $ownerLicenseNumber",
                    $ipAddress
                );
                YellowMsg("This license number is already registered in the system. Check the number and try again.");
            } else {
    // ---------------------------------- Insert the new owner into the People table -------------------------------------------//
                $insertOwnerQuery = "INSERT INTO People (People_name, People_address, People_licence) VALUES (?, ?, ?)";
                $insertOwnerStmt = $con->prepare($insertOwnerQuery);

                if ($insertOwnerStmt) {
                    $insertOwnerStmt->bind_param("sss", $ownerName, $ownerAddress, $ownerLicenseNumber);

                    if ($insertOwnerStmt->execute()) {
                        $newPersonId = $insertOwnerStmt->insert_id;
                        
    //------------------------------------------- Log successful person creation ----------------------------------------------//
                        $changes = "Created new person: Name: $ownerName, License: $ownerLicenseNumber";
                        logAudit($con,$officerId,'People',$newPersonId,'CREATE','New person entry',$changes,$ipAddress);
                        handleSuccess("Owner added successfully. You can now associate this owner with a vehicle.");

                    } else {
                       
                        logAudit($con,$officerId,'People',0, 'CREATE_FAILED','Attempted to create new person',
                            "Failed: " . $insertOwnerStmt->error,
                            $ipAddress
                        );
                        handleError("Error adding owner: " . htmlspecialchars($insertOwnerStmt->error));
                    }
                    $insertOwnerStmt->close();
                }
            }
            $licenseCheckStmt->close();
        }
    }

// ---------------------------------- Adding Vehicle ---------------------------------------------- //
//----------------------------------------------------------------------------------------------//
    if (isset($_POST['add_vehicle'])) {

// ------------------------------ Fetching for form values -------------------------------------//
        $vehiclePlate = mysqli_real_escape_string($con, $_POST['vehicle_plate']);
        $vehicleMake = $_POST['vehicle_make'];
        $vehicleModel = $_POST['vehicle_model'];
        $vehicleColour = $_POST['vehicle_colour'];
        $ownerId = !empty($_POST['owner_id']) ? $_POST['owner_id'] : null;

//------------------------ Checking to see if the vehicle already exists --------------------------------//
        $checkVehicleQuery = "SELECT Vehicle_ID FROM Vehicle WHERE Vehicle_plate = ?";
        $checkVehicleStatement = $con->prepare($checkVehicleQuery);
        $checkVehicleStatement->bind_param("s", $vehiclePlate);
        $checkVehicleStatement->execute();
        $checkVehicleStatement->store_result();

        $vehicleId = null;
        if ($checkVehicleStatement->num_rows > 0) {
//-------------------------- Vehicle already exists, fetch its ID ----------------------------//
            $checkVehicleStatement->bind_result($vehicleId);
            $checkVehicleStatement->fetch();
            $checkVehicleStatement->close();

            YellowMsg("Vehicle already exists in the database.");

    //------------------  Before adding new owner, get current owners ----------------------//
            $currentOwnersQuery = "SELECT GROUP_CONCAT(People_ID) as owners FROM Ownership WHERE Vehicle_ID = ?";
            $currentOwnersStmt = $con->prepare($currentOwnersQuery);
            $currentOwnersStmt->bind_param("i", $vehicleId);
            $currentOwnersStmt->execute();
            $currentOwnersResult = $currentOwnersStmt->get_result();
            $currentOwners = $currentOwnersResult->fetch_assoc();
            $beforeChanges = "Previous owners sharing vehicle: " . ($currentOwners['owners'] ?? 'None');
            $currentOwnersStmt->close();

    //------------------------------ Associating the owner with the existing vehicle --------------------------//
            if ($ownerId) {
                $checkOwnershipQuery = "SELECT 1 FROM Ownership WHERE People_ID = ? AND Vehicle_ID = ?";
                $checkOwnershipStatement = $con->prepare($checkOwnershipQuery);
                $checkOwnershipStatement->bind_param("ii", $ownerId, $vehicleId);
                $checkOwnershipStatement->execute();
                $checkOwnershipStatement->store_result();

                if ($checkOwnershipStatement->num_rows > 0) {
                    YellowMsg("Owner is already associated with this vehicle.");
                } else {
                    $insertOwnershipQuery = "INSERT INTO Ownership (People_ID, Vehicle_ID) VALUES (?, ?)";
                    $insertOwnershipStatement = $con->prepare($insertOwnershipQuery);
                    $insertOwnershipStatement->bind_param("ii", $ownerId, $vehicleId);


                    if ($insertOwnershipStatement->execute()) {
    // ------------------------------------- Logging the ownership addition -------------------------------------------//
                        $changes = "Added Owner ID: " . $ownerId . " to existing vehicle";
                        logAudit($con,$officerId,'Ownership',$vehicleId,'UPDATE',$beforeChanges,$changes,$ipAddress);

                        handleSuccess("Owner associated with the vehicle successfully!");
                    } else {
                        handleError("Error associating owner: " . htmlspecialchars($insertOwnershipStatement->error));
                    }
                    $insertOwnershipStatement->close();
                }
                $checkOwnershipStatement->close();
            }
        } else {
        //------------------------------------------ Inserting new vehicle --------------------------------------------------//
            $insertVehicleQuery = "INSERT INTO Vehicle (Vehicle_plate, Vehicle_make, Vehicle_model, Vehicle_colour) VALUES (?, ?, ?, ?)";
            $insertVehicleStatement = $con->prepare($insertVehicleQuery);
            $insertVehicleStatement->bind_param("ssss", $vehiclePlate, $vehicleMake, $vehicleModel, $vehicleColour);

            if ($insertVehicleStatement->execute()) {
                $vehicleId = $insertVehicleStatement->insert_id;
                
        //----------------------------------------- Logging new vehicle creation ---------------------------------------------//
                $changes = "Created new vehicle: " . $vehiclePlate . " (" . $vehicleMake . " " . $vehicleModel . ")";
                logAudit($con,$officerId,'Vehicle',$vehicleId,'CREATE','New vehicle entry',$changes,$ipAddress);

        //------------------------------- Associate the vehicle with the owner if given -------------------------------//
                if ($ownerId && $vehicleId) {
                    $insertOwnershipQuery = "INSERT INTO Ownership (People_ID, Vehicle_ID) VALUES (?, ?)";
                    $insertOwnershipStatement = $con->prepare($insertOwnershipQuery);
                    $insertOwnershipStatement->bind_param("ii", $ownerId, $vehicleId);

                    if ($insertOwnershipStatement->execute()) {
        //------------------------------------ Logging the initial ownership  -------------------------------------------//
                        $changes = "Assigned initial owner ID: " . $ownerId . " to new vehicle";
                        logAudit($con,$officerId,'Ownership',$vehicleId,'CREATE','Initial ownership assignment',$changes,$ipAddress);

                        handleSuccess("Vehicle and owner association created successfully!");
                    } else {
                        handleError("Error associating owner: " . htmlspecialchars($insertOwnershipStatement->error));
                    }
                    $insertOwnershipStatement->close();
                } else {
                    handleSuccess("Vehicle added successfully!");
                }
            } else {
                handleError("Error adding vehicle: " . htmlspecialchars($insertVehicleStatement->error));
            }
            $insertVehicleStatement->close();
        }
    }
}
?>

<!-- JS file -->
<script src="JS/scripts.js"></script>

