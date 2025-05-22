<?php
include("php/auth.php");
include("php/config.php");
include("php/Audit_logging.php");

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
    <title>Delete Offence</title>
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
            <h5><b><i class="fa fa-trash"></i> Delete Offence</b></h5>
        </header>

        <div class="w3-row-padding">
            <div class="w3-third"></div>
            <div class="w3-third">
                <div class="w3-container w3-card-4 w3-light-grey w3-text-black w3-margin">
                    <h2 class="w3-center">Delete Offence</h2>
                    <form method="POST">
                        <div class="w3-section">
                            <label for="offence_id">Offence ID</label>
                            <input class="w3-input w3-border" type="text" id="offence_id" name="offence_id" 
                                   placeholder="Enter Offence ID" required>
                        </div>
                        <button type="submit" name="delete_offence" 
                                class="w3-button w3-block w3-red w3-section w3-padding">Delete Offence</button>
                    </form>
                </div>
            </div>
            <div class="w3-third"></div>
        </div>
    </div>

<?php
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
              window.location.href='delete_offence.php';
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

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['delete_offence'])) {
    $adminId = $_SESSION['officer_id'] ?? 0;
    $ipAddress = $_SERVER['REMOTE_ADDR'];
    $offenceId = $_POST['offence_id'];

    // --------------------------- Getting the offence details before deletion ---------------------------//
    $detailsQuery = "SELECT * FROM Offence WHERE Offence_ID = ?";
    $detailsStmt = $con->prepare($detailsQuery);
    $detailsStmt->bind_param("i", $offenceId);
    $detailsStmt->execute();
    $offenceDetails = $detailsStmt->get_result()->fetch_assoc();
    $detailsStmt->close();

    if (!$offenceDetails) {
        logAudit($con, $adminId, 'Offence', $offenceId, 'DELETE_FAILED',
                'Attempted to delete non-existent offence',
                "Offence ID $offenceId not found",
                $ipAddress);
        YellowMsg("Invalid Offence ID. Offence does not exist.");
        exit();
    }

    // ------------------------------ Preparing  audit details ------------------------------//
    $beforeChanges = "Offence Details:\n" .
                    "ID: " . $offenceDetails['Offence_ID'] . "\n" .
                    "Description: " . $offenceDetails['Offence_description'] . "\n" .
                    "Max Fine: £" . $offenceDetails['Offence_maxFine'] . "\n" .
                    "Max Points: " . $offenceDetails['Offence_maxPoints'];

    // ------------------------------  Deleting  the offence ------------------------------//
    $deleteQuery = "DELETE FROM Offence WHERE Offence_ID = ?";
    $deleteStmt = $con->prepare($deleteQuery);
    $deleteStmt->bind_param("i", $offenceId);

    if ($deleteStmt->execute()) {
        logAudit($con, $adminId, 'Offence', $offenceId, 'DELETE',
                $beforeChanges,
                "Offence successfully deleted",
                $ipAddress);
        handleSuccess("Offence deleted successfully.");
    } else {
        logAudit($con, $adminId, 'Offence', $offenceId, 'DELETE_FAILED',
                $beforeChanges,
                "Delete failed: " . $deleteStmt->error,
                $ipAddress);
        handleError("Failed to delete offence: " . $deleteStmt->error);
    }
    $deleteStmt->close();
}
?>

<script src="JS/scripts.js"></script>
</body>
</html>