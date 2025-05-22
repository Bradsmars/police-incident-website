<?php
include("php/Audit_logging.php");
include("php/auth.php");

//------------------------------Error Handling----------------------------------//
function handleError($message) {
    echo "<div class='w3-container w3-red w3-padding w3-round'>
            <p><strong>Error:</strong> $message</p>
          </div>
          <script>
              alert('$message');
              window.location.href='search_incident.php';
          </script>";
    exit();
}

function handleSuccess($message) {
    echo "<div class='w3-container w3-green w3-padding w3-round'>
            <p><strong>Success:</strong> $message</p>
          </div>
          <script>
              alert('$message');
              window.location.href='search_incident.php';
          </script>";
    exit();
}

// ----------- My Helper functions to get original incident details ------------------//
function getOriginalIncidentDetails($con, $incident_id) {
    $query = "SELECT 
                i.Incident_Report,
                i.Incident_Date,
                i.Incident_Time,
                i.Role,
                v.Vehicle_plate,
                p.People_licence,
                o.Offence_description
              FROM Incident i
              LEFT JOIN Vehicle v ON i.Vehicle_ID = v.Vehicle_ID
              LEFT JOIN People p ON i.People_ID = p.People_ID
              LEFT JOIN Offence o ON i.Offence_ID = o.Offence_ID
              WHERE i.Incident_ID = ?";
    
    $stmt = $con->prepare($query);
    $stmt->bind_param("i", $incident_id);
    $stmt->execute();
    $result = $stmt->get_result();
    $details = $result->fetch_assoc();
    $stmt->close();
    return $details;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // --------------- Verifying user is logged in -------------------------------- //
    if (!isset($_SESSION['valid'])) {
        handleError("Please log in to perform this action.");
    }

    $ipAddress = $_SERVER['REMOTE_ADDR'];

    if (isset($_POST['update'])) {
        $incident_id = $_POST['update'];
        
        // ----------------- Getting the  original incident details for audit -------------------  //
        $originalDetails = getOriginalIncidentDetails($con, $incident_id);
        
        // ----------------- New values ----------------- //
        $incident_report = mysqli_real_escape_string($con, $_POST['incident_report'][$incident_id]);
        $incident_date = $_POST['incident_date'][$incident_id];
        $incident_time = $_POST['incident_time'][$incident_id];
        $role = mysqli_real_escape_string($con, $_POST['role'][$incident_id]);
        $vehicle_plate = mysqli_real_escape_string($con, $_POST['vehicle_plate'][$incident_id]);
        $people_licence = mysqli_real_escape_string($con, $_POST['people_licence'][$incident_id]);

        // --------------------- Checking  if the license number exists -----------------------//
        if (!empty($people_licence)) {
            $peopleIdQuery = "SELECT People_ID FROM People WHERE People_licence = ?";
            $peopleIdStatement = $con->prepare($peopleIdQuery);
            $peopleIdStatement->bind_param("s", $people_licence);
            $peopleIdStatement->execute();
            $peopleIdStatement->bind_result($people_id);
            $peopleIdStatement->fetch();
            $peopleIdStatement->close();

            if (!$people_id) {
                handleError("Invalid People Licence provided.");
            }
        } else {
            $people_id = null;
        }

        // -------------- Checking if the vehicle plate exists --------------------//
        if (!empty($vehicle_plate)) {
            $vehicleCheckQuery = "SELECT Vehicle_ID FROM Vehicle WHERE Vehicle_plate = ?";
            $vehicleCheckStmt = $con->prepare($vehicleCheckQuery);
            $vehicleCheckStmt->bind_param("s", $vehicle_plate);
            $vehicleCheckStmt->execute();
            $vehicleCheckStmt->bind_result($vehicle_id);
            $vehicleCheckStmt->fetch();
            $vehicleCheckStmt->close();

            if (!$vehicle_id) {
                handleError("Invalid Vehicle Plate.");
            }
        } else {
            $vehicle_id = null;
        }

        // ------------------ Comparing and building my  changes list ------------------ //
        $changesList = [];
        if ($originalDetails['Incident_Report'] !== $incident_report) {
            $changesList[] = "Report changed from: '" . $originalDetails['Incident_Report'] . "' to: '" . $incident_report . "'";
        }
        if ($originalDetails['Incident_Date'] !== $incident_date) {
            $changesList[] = "Date changed from: " . $originalDetails['Incident_Date'] . " to: " . $incident_date;
        }
        if ($originalDetails['Incident_Time'] !== $incident_time) {
            $changesList[] = "Time changed from: " . $originalDetails['Incident_Time'] . " to: " . $incident_time;
        }
        if ($originalDetails['Vehicle_plate'] !== $vehicle_plate) {
            $changesList[] = "Vehicle changed from: " . ($originalDetails['Vehicle_plate'] ?? 'None') . " to: " . ($vehicle_plate ?? 'None');
        }
        if ($originalDetails['People_licence'] !== $people_licence) {
            $changesList[] = "Person License changed from: " . ($originalDetails['People_licence'] ?? 'None') . " to: " . ($people_licence ?? 'None');
        }
        if ($originalDetails['Role'] !== $role) {
            $changesList[] = "Role changed from: '" . $originalDetails['Role'] . "' to: '" . $role . "'";
        }

        // ---------------- Updating my incident ----------------- //
        $updateIncidentQuery = "UPDATE Incident 
                              SET Incident_Report = ?,
                                  Incident_Date = ?,
                                  Incident_Time = ?,
                                  People_ID = ?,
                                  Vehicle_ID = ?,
                                  Role = ?
                              WHERE Incident_ID = ?";
        $updateIncidentStatement = $con->prepare($updateIncidentQuery);
        $updateIncidentStatement->bind_param("ssssssi", 
            $incident_report,
            $incident_date,
            $incident_time,
            $people_id,
            $vehicle_id,
            $role,
            $incident_id
        );

        if ($updateIncidentStatement->execute()) {
            $changes = "Original State - " .
                      "Date: " . $originalDetails['Incident_Date'] . ", " .
                      "Time: " . $originalDetails['Incident_Time'] . ", " .
                      "Report: " . $originalDetails['Incident_Report'] . ", " .
                      "Vehicle: " . ($originalDetails['Vehicle_plate'] ?? 'None') . ", " .
                      "License: " . ($originalDetails['People_licence'] ?? 'None') . ", " .
                      "Role: " . ($originalDetails['Role'] ?? 'None') . "\n" .
                      "Modified by Officer: " . $officer_name . " (ID: " . $officer_id . ", Role: " . $officer_role . ")";

            $beforeChanges = empty($changesList) ? 
                           "No changes made" : 
                           "Changes Made:\n" . implode("\n", $changesList);

            logAudit($con,$officer_id,'Incident',$incident_id,'UPDATE',$changes,
                $beforeChanges,
                $ipAddress
            );
            
            handleSuccess("Incident updated successfully.");
        } else {
            logAudit($con,$officer_id,'Incident',$incident_id,'UPDATE_FAILED',
                "Attempted update by Officer: " . $officer_name,
                "Update failed: " . $updateIncidentStatement->error,
                $ipAddress
            );
            handleError("Failed to update incident: " . $updateIncidentStatement->error);
        }
        $updateIncidentStatement->close();
    }

    if (isset($_POST['delete'])) {
        $incident_id = $_POST['delete'];
        $originalDetails = getOriginalIncidentDetails($con, $incident_id);

        $deleteIncidentQuery = "DELETE FROM Incident WHERE Incident_ID = ?";
        $deleteIncidentStatement = $con->prepare($deleteIncidentQuery);
        $deleteIncidentStatement->bind_param("i", $incident_id);

        if ($deleteIncidentStatement->execute()) {
            $changes = "Deleted Incident Details - " .
                      "Report: " . $originalDetails['Incident_Report'] . ", " .
                      "Date: " . $originalDetails['Incident_Date'] . ", " .
                      "Time: " . $originalDetails['Incident_Time'] . ", " .
                      "Role: " . $originalDetails['Role'] . ", " .
                      "Vehicle: " . ($originalDetails['Vehicle_plate'] ?? 'None') . ", " .
                      "License: " . ($originalDetails['People_licence'] ?? 'None') . ", " .
                      "Offence: " . ($originalDetails['Offence_description'] ?? 'None') . "\n" .
                      "Deleted by Officer: " . $officer_name . " (ID: " . $officer_id . ", Role: " . $officer_role . ")";

            logAudit($con,$officer_id,'Incident',$incident_id,'DELETE',$changes,
                "Incident successfully deleted",
                $ipAddress
            );
            
            handleSuccess("Incident deleted successfully.");
        } else {
            logAudit(
                $con,
                $officer_id,
                'Incident',
                $incident_id,
                'DELETE_FAILED',
                "Attempted deletion by Officer: " . $officer_name,
                "Delete failed: " . $deleteIncidentStatement->error,
                $ipAddress
            );
            handleError("Failed to delete incident: " . $deleteIncidentStatement->error);
        }
        $deleteIncidentStatement->close();
    }
}

// -------------- Searching for the incident logging ----------------- //
if (isset($_POST['search_incident'])) {
    if (!isset($_SESSION['valid'])) {
        handleError("Please log in to perform this action.");
    }

    $search_query = $_POST['search_incident'];
    $ipAddress = $_SERVER['REMOTE_ADDR'];
    
    logAudit($con,$officer_id,'Incident',0,'READ',
        'Search initiated by Officer: ' . $officer_name . ' (Role: ' . $officer_role . ')',
        'Search query: ' . $search_query,
        $ipAddress);
}
?>