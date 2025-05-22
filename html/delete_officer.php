<?php
include("php/auth.php");
include("php/config.php");
include("php/Audit_logging.php");  // Added for audit logging functionality

// Check if the user is logged in and has the 'Administrator' role
if (!isset($_SESSION['valid']) || !isset($_SESSION['role']) || $_SESSION['role'] !== 'Administrator') {
    echo "<div class='w3-container w3-red w3-padding'><p>Access denied. Administrator privileges required.</p></div>";
    exit();
}

include("php/header.php");
include("php/sidebar.php");
?>

<!DOCTYPE html>
<html>
<head>
    <title>Delete Officer</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="style/pages.css"> <!-- Link your external CSS -->
</head>
<body class="w3-light-grey">
   
    <div class="w3-overlay w3-hide-large" onclick="w3_close()" id="myOverlay"></div>

    <!-- Page content -->
    <div class="w3-main">
        <!-- Header -->
        <header class="w3-container">
            <h5><b><i class="fa fa-user-times"></i> Delete Officer</b></h5>
        </header>

        <div class="w3-row-padding">
            <div class="w3-third"></div>
            <div class="w3-third">
                <div class="w3-container w3-card-4 w3-light-grey w3-text-black w3-margin">
                    <h2 class="w3-center">Delete Officer</h2>
                    <form action="delete_officer.php" method="POST" onsubmit="return deleteOfficerForm()">
                        <div class="w3-section">
                            <label for="officer_id">Officer ID</label>
                            <input 
                                class="w3-input w3-border" type="text" id="officer_id" name="officer_id" placeholder="Enter Officer ID" required></div>

                                
                        <button type="submit" name="delete_officer" class="w3-button w3-block w3-red w3-section w3-padding">Delete Officer</button>
                    </form>
                </div>
            </div>
            <div class="w3-third"></div>
        </div>
    </div>

<?php

// Handling functions
function handleError($message) {
    echo "<div class='w3-container w3-red w3-padding w3-round'>
            <p><strong>Error:</strong> $message</p>
          </div>
          <script>
              alert('$message');
              window.history.back();
          </script>";
}

function handleSuccess($message) {
    echo "<div class='w3-container w3-green w3-padding w3-round'>
            <p><strong>Success:</strong> $message</p>
          </div>
          <script>
              alert('$message');
              window.location.href='delete_officer.php';
          </script>";
}

function YellowMsg($message) {
    echo "<div class='w3-container w3-yellow w3-padding w3-round'>
            <p><strong>Warning:</strong> $message</p>
          </div>
          <script>
              alert('$message');
              window.history.back();
          </script>";
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['delete_officer'])) {
        $targetOfficerId = $_POST['officer_id'];
        $adminId = $_SESSION['officer_id'] ?? 0;
        $ipAddress = $_SERVER['REMOTE_ADDR'];

        // --------- Getting the officer details before deletion for audit log ----------------------//
        $officerDetailsQuery = "SELECT Officer.*, OfficerLogin.Officer_role 
                              FROM Officer 
                              LEFT JOIN OfficerLogin ON Officer.Officer_ID = OfficerLogin.Officer_ID 
                              WHERE Officer.Officer_ID = ?";
        $officerDetailsStatement = $con->prepare($officerDetailsQuery);
        $officerDetailsStatement->bind_param("i", $targetOfficerId);
        $officerDetailsStatement->execute();
        $officerDetails = $officerDetailsStatement->get_result()->fetch_assoc();
        $officerDetailsStatement->close();

        // ---------------------  Checking to see the  if officer exists ----------------------//
        if (!$officerDetails) {
            logAudit($con,$adminId,'Officer',$targetOfficerId,'DELETE_FAILED','Attempted to delete non-existent officer',
                "Officer ID $targetOfficerId not found",
                $ipAddress);
            YellowMsg("Invalid Officer ID. Officer does not exist.");
            return;
        }

        //----------------------------  Preparing the  audit log details ---------------------------//
        $beforeChanges = "Officer Details:\n" .
                        "ID: " . $officerDetails['Officer_ID'] . "\n" .
                        "Name: " . $officerDetails['Officer_Name'] . "\n" .
                        "Badge: " . $officerDetails['Officer_BadgeNumber'] . "\n" .
                        "Role: " . $officerDetails['Officer_role'] . "\n" .
                        "Department: " . ($officerDetails['Department'] ?? 'N/A');

        //--------------------------------  Deleting the officer -------------------------------------//
        $deleteOfficerQuery = "DELETE FROM Officer WHERE Officer_ID = ?";
        $deleteStatement = $con->prepare($deleteOfficerQuery);
        $deleteStatement->bind_param("i", $targetOfficerId);
        
        if ($deleteStatement->execute()) {
            logAudit($con,$adminId,'Officer',$targetOfficerId,'DELETE',$beforeChanges,
                "Officer successfully deleted",
                $ipAddress
            );
            handleSuccess("Officer deleted successfully.");
        } else {
            logAudit($con,$adminId,'Officer',$targetOfficerId,'DELETE_FAILED',$beforeChanges,
                "Delete failed: " . $deleteStatement->error,
                $ipAddress);
            handleError("Failed to delete officer: " . $deleteStatement->error);
        }
        $deleteStatement->close();
    }
}
?>

<script src="JS/scripts.js"></script>
</body>
</html>

