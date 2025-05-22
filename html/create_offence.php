<?php
include("php/auth.php");
include("php/config.php");


//  -------------------------------- Checking the  administrator access ---------------------------------//
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
    <title>Create Offence</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="style/pages.css">
</head>
<body class="w3-light-grey">
    <div class="w3-overlay w3-hide-large" onclick="w3_close()" id="myOverlay"></div>

    <div class="w3-main">
        <header class="w3-container">
            <h5><b><i class="fa fa-plus-circle"></i> Create New Offence</b></h5>
        </header>

        <div class="w3-row-padding">
            <div class="w3-third"></div>
            <div class="w3-third">
                <div class="w3-container w3-card-4 w3-light-grey w3-text-black w3-margin">
                    <h2 class="w3-center">Add New Offence</h2>
                    <form method="POST">
                        <div class="w3-section">
                            <label for="offence_description">Offence Description</label>
                            <input class="w3-input w3-border" type="text" id="offence_description" name="offence_description" required>
                        </div>

                        <div class="w3-section">
                            <label for="offence_maxfine">Maximum Fine (£)</label>
                            <input class="w3-input w3-border" type="number" id="offence_maxfine" name="offence_maxfine" required>
                        </div>

                        <div class="w3-section">
                            <label for="offence_maxpoints">Maximum Points</label>
                            <input class="w3-input w3-border" type="number" id="offence_maxpoints" name="offence_maxpoints" required>
                        </div>

                        <button type="submit" name="create_offence" class="w3-button w3-block w3-green w3-section w3-padding">Create Offence</button>
                    </form>
                </div>
            </div>
            <div class="w3-third"></div>
        </div>
    </div>

<?php
include("php/Audit_logging.php");
// --------------------------------------- Handling error and success f functions ---------------------------------//
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
              window.location.href='create_offence.php';
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

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['create_offence'])) {
    $adminId = $_SESSION['officer_id'] ?? 0;
    $ipAddress = $_SERVER['REMOTE_ADDR'];
    
    $offenceDescription = trim($_POST['offence_description']);
    $maxFine = (int)$_POST['offence_maxfine'];
    $maxPoints = (int)$_POST['offence_maxpoints'];

    // -------------------------- Checking for the duplicate offence description ---------------------------------//
    $checkQuery = "SELECT Offence_ID FROM Offence WHERE Offence_description = ?";
    $checkStmt = $con->prepare($checkQuery);
    $checkStmt->bind_param("s", $offenceDescription);
    $checkStmt->execute();
    $checkStmt->store_result();

    if ($checkStmt->num_rows > 0) {
        $checkStmt->close();
        logAudit($con, $adminId, 'Offence', 0, 'CREATE_FAILED', 
                'Attempted to create duplicate offence', 
                "Duplicate offence description: $offenceDescription",
                $ipAddress);
        YellowMsg("This offence already exists in the system.");
    }

    // --------------------------------------------- Inserting the new offence --------------------------------------//
    $insertQuery = "INSERT INTO Offence (Offence_description, Offence_maxFine, Offence_maxPoints, Officer_ID) 
                   VALUES (?, ?, ?, ?)";
    $insertStmt = $con->prepare($insertQuery);
    $insertStmt->bind_param("siii", $offenceDescription, $maxFine, $maxPoints, $adminId);

    if ($insertStmt->execute()) {
        $newOffenceId = $insertStmt->insert_id;
        logAudit($con, $adminId, 'Offence', $newOffenceId, 'CREATE',
                'New offence created',
                "Description: $offenceDescription\nMax Fine: £$maxFine\nMax Points: $maxPoints",
                $ipAddress);
        handleSuccess("Offence created successfully.");
    } else {
        logAudit($con, $adminId, 'Offence', 0, 'CREATE_FAILED',
                'Failed to create offence',
                "Error: " . $insertStmt->error,
                $ipAddress);
        handleError("Failed to create offence: " . $insertStmt->error);
    }
    $insertStmt->close();
}
?>

<script src="JS/scripts.js"></script>
</body>
</html>