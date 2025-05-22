<?php
include("php/header.php");
include("php/sidebar.php");
include("php/config.php");

?>

<!DOCTYPE html>
<html>
<head>
    <title>Search Vehicle</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="style/pages.css"> <!-- Link my external CSS -->
</head>
<body class="w3-light-grey">

<!-- Overlay effect for small screens -->
<div class="w3-overlay w3-hide-large" onclick="w3_close()" id="myOverlay"></div>

<!--------------------------- Page content ------------------------------------->
<div class="w3-main">
    <!-- Header -->
    <header class="w3-container">
        <h5><b><i class="fa fa-search"></i> Search Vehicle</b></h5>
    </header>

<!------------------------------ Searching the  People Form ---------------------------0--->
<div class="w3-row-padding">
    <div class="w3-third"></div>
    <div class="w3-third">
        <form class="w3-container w3-card-4 w3-white w3-padding" method="POST">
            <label for="search_people_input">Search by Name or Licence Number:</label>
            <input class="w3-input w3-border w3-round" type="text" id="search_people_input" name="search_people_input" placeholder="Enter Name or Licence Number">
            <button class="w3-button w3-blue w3-margin-top w3-round" type="submit">Search People</button>
        </form>
    </div>
    <div class="w3-third"></div>
</div>

<!------------------------------------------ Searching the Results for People ----------------------------------------->
<?php
if (isset($_POST['search_people_input'])) {
    include("php/config.php");
    $searchPeopleInput = $_POST['search_people_input'];

    // -------------------- Query to fetch people based on name or license number -------------------//
    $fetchPeopleQuery = "SELECT * FROM People WHERE People_name LIKE ? OR People_licence LIKE ?";
    $preparePeopleStatement = $con->prepare($fetchPeopleQuery);
    $searchPeopleTerm = "%$searchPeopleInput%";
    $preparePeopleStatement->bind_param("ss", $searchPeopleTerm, $searchPeopleTerm);
    $preparePeopleStatement->execute();
    $peopleResults = $preparePeopleStatement->get_result();

    if ($peopleResults->num_rows > 0) {
        echo '<div class="w3-container w3-padding">
                <h5>Search Results for People:</h5>
                <table class="w3-table w3-striped w3-bordered w3-white">
                    <tr>
                        <th>Name</th>
                        <th>Address</th>
                        <th>Licence Number</th>
                    </tr>';
        while ($personRow = $peopleResults->fetch_assoc()) {
            echo '<tr>
                    <td>' . htmlspecialchars($personRow['People_name']) . '</td>
                    <td>' . htmlspecialchars($personRow['People_address']) . '</td>
                    <td>' . htmlspecialchars($personRow['People_licence']) . '</td>
                </tr>';
        }
        echo '</table>
            </div>';
    } else {
        handleError("No results found for the given search.");
    }
    $preparePeopleStatement->close();
}
?>

<!--Search Vehicle Form -->
<div class="w3-row-padding">
    <div class="w3-third"></div>
    <div class="w3-third">
        <form class="w3-container w3-card-4 w3-white w3-padding" method="POST">
            <label for="registration_plate_input">Search by Vehicle plate:</label>
            <input class="w3-input w3-border w3-round" type="text" id="registration_plate_input" name="registration_plate_input" placeholder="Enter Registration Number">
            <button class="w3-button w3-blue w3-margin-top w3-round" name="search_vehicle" type="submit">Search Vehicle</button>
        </form>
    </div>
    <div class="w3-third"></div>
</div>

<!-- Search Results for Vehicle -->
<?php
//-----------------------------------------------------------------------------//
function handleError($message) {
    echo "<div class='w3-container red-msg'><p>$message</p></div>";
    exit();
}

function handleSuccess($message) {
    echo "<div class='w3-container green-msg'><p>$message</p></div>";
    exit();
}

function YellowMsg($message) {
    echo "<div class='w3-container yellow-msg'><p>$message</p></div>";
    exit();
}
//------------------------------------------------------------------------------//

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['search_vehicle'])) {
    $registrationPlateInput = mysqli_real_escape_string($con, $_POST['registration_plate_input']);

//------------------------------------------------------------------------------//
    // --------------- SQL query to fetch vehicle and related incident details from db -----------------//
    $getMultipleTablesQuery = "
        SELECT 
            Vehicle.Vehicle_plate AS RegistrationNumber,
            Vehicle.Vehicle_make AS VehicleMake,
            Vehicle.Vehicle_model AS VehicleModel,
            Vehicle.Vehicle_colour AS VehicleColour,
            Owners.People_name AS OwnerName,
            Owners.People_licence AS OwnerLicence,
            Incident.Incident_Report AS IncidentReport,
            Incident.Incident_Date AS IncidentDate,
            People.People_name AS ParticipantName,
            Incident.Role AS ParticipantRole
        FROM Vehicle
        LEFT JOIN Ownership ON Vehicle.Vehicle_ID = Ownership.Vehicle_ID
        LEFT JOIN People AS Owners ON Ownership.People_ID = Owners.People_ID
        LEFT JOIN Incident ON Vehicle.Vehicle_ID = Incident.Vehicle_ID
        LEFT JOIN People ON Incident.People_ID = People.People_ID
        WHERE Vehicle.Vehicle_plate = ?";

    $prepareVehicleStatement = $con->prepare($getMultipleTablesQuery);
    if ($prepareVehicleStatement) {
        $prepareVehicleStatement->bind_param("s", $registrationPlateInput);
        $prepareVehicleStatement->execute();
        $vehicleResults = $prepareVehicleStatement->get_result();

        if ($vehicleResults->num_rows > 0) {
            echo '<div class="w3-container w3-padding">
                    <h5>Search Results for Vehicle:</h5>
                    <div class="w3-responsive">
                    <table class="w3-table w3-striped w3-bordered w3-white">
                        <tr class="w3-blue">
                            <th>Registration Number</th>
                            <th>Vehicle Make</th>
                            <th>Vehicle Model</th>
                            <th>Vehicle Colour</th>
                            <th>Owner Name</th>
                            <th>Owner Licence</th>
                            <th>Incident Report</th>
                            <th>Incident Date</th>
                            <th>Participant Name</th>
                            <th>Role</th>
                        </tr>';
            while ($vehicleRow = $vehicleResults->fetch_assoc()) {
                echo '<tr>
                        <td>' . htmlspecialchars($vehicleRow['RegistrationNumber']) . '</td>
                        <td>' . htmlspecialchars($vehicleRow['VehicleMake'] ?? 'Unknown') . '</td>
                        <td>' . htmlspecialchars($vehicleRow['VehicleModel'] ?? 'Unknown') . '</td>
                        <td>' . htmlspecialchars($vehicleRow['VehicleColour']) . '</td>
                        <td>' . htmlspecialchars($vehicleRow['OwnerName'] ?? 'Unknown') . '</td>
                        <td>' . htmlspecialchars($vehicleRow['OwnerLicence'] ?? 'Unknown') . '</td>
                        <td>' . htmlspecialchars($vehicleRow['IncidentReport'] ?? 'No Incidents') . '</td>
                        <td>' . htmlspecialchars($vehicleRow['IncidentDate'] ?? 'N/A') . '</td>
                        <td>' . htmlspecialchars($vehicleRow['ParticipantName'] ?? 'N/A') . '</td>
                        <td>' . htmlspecialchars($vehicleRow['ParticipantRole'] ?? 'N/A') . '</td>
                    </tr>';
            }
            echo '</table>
                </div>';
        } else {
            handleError("No results found for the registration number given by you.");
        }

        $prepareVehicleStatement->close();
    } else {
        handleError("Error, unable to prepare the query.");
    }
}
?>
