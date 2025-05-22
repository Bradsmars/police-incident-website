<?php
include("php/header.php");
include("php/sidebar.php");
include("php/config.php");

?>

<!DOCTYPE html>
<html>
<head>
    <title>Search Incident</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="style/pages.css">
</head>
<body class="w3-light-grey">

<div class="w3-main">
    <!-- Header -->
    <header class="w3-container">
        <h5><b><i class="fa fa-search"></i> Search Incident & Edit </b></h5>
    </header>

    <!-- Search Form -->
    <div class="w3-row-padding">
        <div class="w3-third"></div>
        <div class="w3-third">
            <form class="w3-container w3-card-4 w3-white w3-padding" method="POST">
                <label for="search_incident">Search incident by Date, Vehicle registration, Person Name or Incident ID:</label>
                <input class="w3-input w3-border w3-round" type="text" id="search_incident" name="search_incident" placeholder="Enter Incident or Plate">
                <button class="w3-button w3-blue w3-margin-top w3-round" type="submit">Search Incident</button>
            </form>
        </div>
        <div class="w3-third"></div>
    </div>

    <!-- Search Results -->
    <!-- reference: https://stackoverflow.com/questions/43286387/adding-a-delete-button-in-php-on-each-row-of-a-mysql-table -->
    <!-- reference: https://www.youtube.com/watch?v=JydKzPOni3k -->
    <!-- reference: https://www.youtube.com/watch?v=yifY51wjnSg&list=PLS1QulWo1RIagiNF9X4B_mkJYzjCbx6GI -->
<?php
if (isset($_POST['search_incident'])) {
    $search_query = $_POST['search_incident'];

    // SQL query to fetch incidents and related details
    $query = "
        SELECT 
            Incident.Incident_ID, 
            Incident.Incident_Date, 
            Incident.Incident_Time, 
            Incident.Incident_Report,
            Vehicle.Vehicle_plate, 
            People.People_name, 
            People.People_licence,
            Offence.Offence_description, 
            Incident.Role
        FROM Incident
        LEFT JOIN Vehicle ON Incident.Vehicle_ID = Vehicle.Vehicle_ID
        LEFT JOIN People ON Incident.People_ID = People.People_ID
        LEFT JOIN Offence ON Incident.Offence_ID = Offence.Offence_ID
        WHERE 
            Incident.Incident_ID = ? OR 
            Incident.Incident_Date = ? OR
            Vehicle.Vehicle_plate LIKE ? OR 
            People.People_name LIKE ? OR
            Incident.Role LIKE ?";

    $statement = $con->prepare($query);
    if ($statement) {
        $search_param = "%$search_query%";
        // Binding my search querys parameters such as incident id, date, vehicle plate, person name and role
        $statement->bind_param("sssss", $search_query, $search_query, $search_param, $search_param, $search_param);
        $statement->execute();
        $result = $statement->get_result();

        // Fetching the list of offences
        $offenceQuery = "SELECT Offence_ID, Offence_description FROM Offence";
        $offenceResult = $con->query($offenceQuery);
        $offences = [];
        while ($offenceRow = $offenceResult->fetch_assoc()) {
            $offences[] = $offenceRow;
        }

        // Fetching  the list of people with their licences
        $peopleQuery = "SELECT People_ID, People_name, People_licence FROM People";
        $peopleResult = $con->query($peopleQuery);
        $people = [];
        while ($peopleRow = $peopleResult->fetch_assoc()) {
            $people[] = $peopleRow;
        }

        $vehicleQuery = "SELECT Vehicle_ID, Vehicle_plate FROM Vehicle";
        $vehicleResult = $con->query($vehicleQuery);
        $vehicles = [];
        while ($vehicleRow = $vehicleResult->fetch_assoc()) {
            $vehicles[] = $vehicleRow;
        }


        if ($result->num_rows > 0) {
            echo '<div class="w3-container w3-padding">
                    <h5>Search Results for Incidents:</h5>
                    <form method="POST" action="update_delete_incident.php" onsubmit="return validateFileIncidentForm()>
                    <div class="w3-responsive">
                    <table class="w3-table w3-striped w3-bordered w3-white">
                        <tr class="w3-blue">
                            <th>Incident ID</th>
                            <th>Incident Date</th>
                            <th>Incident Time</th>
                            <th>Incident Report</th>
                            <th>Vehicle Registration</th>
                            <th>Person Involved</th>
                            <th>Offence</th>
                            <th>Role</th>
                            <th>Update & Delete</th>
                        </tr>';

                        while ($row = $result->fetch_assoc()) {
                            echo '<tr>
                                    <td>' . htmlspecialchars($row['Incident_ID'] ?? 'N/A') . '</td>
                                    <td>
                                        <input 
                                            type="date" 
                                            name="incident_date[' . htmlspecialchars($row['Incident_ID'] ?? 'N/A') . ']" 
                                            value="' . htmlspecialchars($row['Incident_Date'] ?? '') . '" 
                                            class="w3-input">  </td>
                                            
                                    <td>
                                        <input 
                                            type="time" 
                                            name="incident_time[' . htmlspecialchars($row['Incident_ID'] ?? 'N/A') . ']" 
                                            value="' . htmlspecialchars($row['Incident_Time'] ?? '') . '" 
                                            class="w3-input"></td>

                                    <td>
                                        <input 
                                            type="text" 
                                            name="incident_report[' . htmlspecialchars($row['Incident_ID'] ?? 'N/A') . ']" 
                                            value="' . htmlspecialchars($row['Incident_Report'] ?? '') . '" 
                                            class="w3-input"></td>

                                    <td>
                                        <select name="vehicle_plate[' . htmlspecialchars($row['Incident_ID']) . ']" class="w3-select w3-border">
                                            <option value="">Select Vehicle</option>';
                                            foreach ($vehicles as $vehicle) {
                                                $selected = ($vehicle['Vehicle_plate'] == $row['Vehicle_plate']) ? 'selected' : '';
                                                echo '<option value="' . htmlspecialchars($vehicle['Vehicle_plate']) . '" ' . $selected . '>' 
                                                    . htmlspecialchars($vehicle['Vehicle_plate']) . '</option>';}echo '</select></td>
                                    <td>
                                        <input 
                                            type="text"
                                            id="person_licence_' . htmlspecialchars($row['Incident_ID'] ?? 'N/A') . '"
                                            name="people_licence[' . htmlspecialchars($row['Incident_ID'] ?? 'N/A') . ']" 
                                            value="' . htmlspecialchars($row['People_licence'] ?? '') . '" 
                                            placeholder="Enter Licence Number" 
                                            class="w3-input w3-border"></td>


                                    <td>
                                        <select name="offence_id[' . htmlspecialchars($row['Incident_ID'] ?? 'N/A') . ']" class="w3-select w3-border">
                                            <option value="">Select Offence</option>';
                                            foreach ($offences as $offence) {
                                                $selected = ($offence['Offence_ID'] == $row['Offence_ID']) ? 'selected' : '';
                                                echo '<option value="' . htmlspecialchars($offence['Offence_ID']) . '" ' . $selected . '>' 
                                                    . htmlspecialchars($offence['Offence_description']) . '</option>';}echo '          </select></td>

                                    <td>
                                        <input 
                                            type="text" 
                                            name="role[' . htmlspecialchars($row['Incident_ID'] ?? 'N/A') . ']" 
                                            value="' . htmlspecialchars($row['Role'] ?? 'N/A') . '" 
                                            class="w3-input"></td>


                                    <td>
                                        <button 
                                            class="w3-button w3-green w3-small" 
                                            name="update" 
                                            value="' . htmlspecialchars($row['Incident_ID'] ?? 'N/A') . '">
                                            Update


                                        
                                        </button>
                                        <button 
                                            class="w3-button w3-red w3-small" 
                                            name="delete" 
                                            value="' . htmlspecialchars($row['Incident_ID'] ?? 'N/A') . '">
                                            Delete
                                        </button>
                                    </td>
                                </tr>';}
                        
                        echo '</table></div></form></div>';
                        } else {
                            echo '<div class="w3-container red-msg"><p>No results found for query.</p></div>';
                        }
                        
                        $statement->close();
                        } else {
                            echo '<div class="w3-container red-msg"><p>Error: Unable to prepare the query.</p></div>';
                        }
                    }                        

?>
</div>

</body>
</html>