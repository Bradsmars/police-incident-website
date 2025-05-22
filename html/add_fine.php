<?php
include("php/auth.php");
include("php/Audit_logging.php");

// ----------------- Checking to see if the user is logged in and has the 'Administrator' role -----------------//
if (!isset($_SESSION['valid']) || !isset($_SESSION['role']) || $_SESSION['role'] !== 'Administrator') {
    echo "<div class='w3-container w3-red w3-padding'><p>Access denied. Administrator privileges required.</p></div>";
    exit();
}
include("php/config.php");
include("php/header.php");
include("php/sidebar.php");
?>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Fines</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="style/pages.css"> 
</head>
<body class="w3-light-grey">
    
    <div class="w3-overlay w3-hide-large" onclick="w3_close()" id="myOverlay"></div>

    <!-- Page content ------->
    <div class="w3-main">
        <!-- Header -------->
        <header class="w3-container">
            <h5><b><i class="fa fa-gavel"></i> Manage Fines</b></h5>
        </header>

        <!-------- Fine Association Form -------->
        <div class="w3-row-padding">
            <div class="w3-third"></div>
            <div class="w3-third">
                <div class="w3-container w3-card-4 w3-light-grey w3-text-black w3-margin">
                    <h2 class="w3-center">Associate Fine to Report</h2>
                    <form method="POST" onsubmit="return validateForm1()">
                        <div class="w3-section">
                            <label for="incident_id">Incident ID</label>
                            <input class="w3-input w3-border" type="number" id="incident_id" name="incident_id" required>
                        </div>
                        <div class="w3-section">
                            <label for="fine_amount">Fine Amount</label>
                            <input class="w3-input w3-border" type="number" id="fine_amount" name="fine_amount" required>
                        </div>
                        <div class="w3-section">
                            <label for="fine_points">Fine Points</label>
                            <input class="w3-input w3-border" type="number" id="fine_points" name="fine_points" required>
                        </div>
                        <button type="submit" name="add_fine" class="w3-button w3-block w3-green w3-section w3-padding">Add Fine</button>
                    </form>
                </div>
            </div>
            <div class="w3-third"></div>
        </div>

        <!-- Table to Remove Fines -->
        <div class="w3-row-padding">
            <div class="w3-third"></div>
            <div class="w3-third">
                <div class="w3-container w3-card-4 w3-light-grey w3-text-black w3-margin">
                    <h2 class="w3-center">Remove Fines</h2>
                    <div class="w3-responsive">
                        <table class="w3-table w3-bordered w3-striped">
                            <tr class="w3-blue">
                                <th>Fine ID</th>
                                <th>Incident ID</th>
                                <th>Amount</th>
                                <th>Points</th>
                                <th>Action</th>
                            </tr>
                            <?php
                            // Fetching fines from the database
                            $fetchFinesQuery = "SELECT Fine_ID, Incident_ID, Fine_Amount, Fine_Points FROM Fines";
                            $finesResult = $con->query($fetchFinesQuery);

                            if ($finesResult->num_rows > 0) {
                                while ($fine = $finesResult->fetch_assoc()) {
                                    echo '<tr>
                                            <td>' . htmlspecialchars($fine['Fine_ID']) . '</td>
                                            <td>' . htmlspecialchars($fine['Incident_ID']) . '</td>
                                            <td>' . htmlspecialchars($fine['Fine_Amount']) . '</td>
                                            <td>' . htmlspecialchars($fine['Fine_Points']) . '</td>
                                            <td>
                                                <form method="POST" style="margin: 0;">
                                                    <input type="hidden" name="fine_id" value="' . htmlspecialchars($fine['Fine_ID']) . '">
                                                    <button type="submit" name="delete_fine" class="w3-button w3-red w3-small">Delete</button>
                                                </form>
                                            </td>
                                          </tr>';}
                            } else {
                                echo '<tr>
                                        <td colspan="5" class="w3-center">No fines found.</td>
                                      </tr>';
                            }
                            ?>
                        </table>
                    </div>
                </div>
            </div>
            <div class="w3-third"></div>
        </div>
    </div>

 
<?php
include("php/auth.php");


// ----------------- Checking to see if the user is logged in and has the 'Administrator' role -----------------//
if (!isset($_SESSION['valid']) || !isset($_SESSION['role']) || $_SESSION['role'] !== 'Administrator') {
    echo "<div class='w3-container w3-red w3-padding'><p>Access denied. Administrator privileges required.</p></div>";
    exit();
}
include("php/config.php");

// ----------------- Helper functions for error and success messages -----------------//
function handleError($message) {
    echo "<div class='w3-container red-msg'><p>$message</p></div>";
    exit();
}
function handleSuccess($message) {
    echo "<div class='w3-container green-msg'><p>$message</p></div>";
}

// -------------------------- Processing the field add fine ---------------------------------//
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['add_fine'])) {
    $officerId = $_SESSION['officer_id'] ?? 0;
    $ipAddress = $_SERVER['REMOTE_ADDR'];

    // -------------------- Getting form data ---------------------------------//
    $incidentId = $_POST['incident_id'];
    $fineAmount = $_POST['fine_amount'];
    $finePoints = $_POST['fine_points'];

    // ---------- Validating if the Incident ID exists or not -------------------//
    $incidentQuery = "SELECT * FROM Incident WHERE Incident_ID = ?";
    $incidentStatement = $con->prepare($incidentQuery);
    $incidentStatement->bind_param("i", $incidentId);
    $incidentStatement->execute();
    $result = $incidentStatement->get_result();

    if ($result->num_rows === 0) {
        logAudit($con, $officerId, 'Fines', $incidentId, 'CREATE_FAILED',
            'Attempted to add fine to non-existent incident',
            "Incident ID: $incidentId not found",
            $ipAddress
        );
        $incidentStatement->close();
        handleError("Incident ID does not exist. Please check and try again.");
    }
    $incidentStatement->close();

    // ---------- Checking for duplicate fine for the same Incident ID ----------//
    $duplicateCheckQuery = "SELECT * FROM Fines WHERE Incident_ID = ?";
    $duplicateCheckStmt = $con->prepare($duplicateCheckQuery);
    $duplicateCheckStmt->bind_param("i", $incidentId);
    $duplicateCheckStmt->execute();
    $duplicateResult = $duplicateCheckStmt->get_result();

    if ($duplicateResult->num_rows > 0) {
        logAudit($con, $officerId, 'Fines', $incidentId, 'CREATE_FAILED',
            'Attempted to add duplicate fine',
            "Duplicate fine detected for Incident ID: $incidentId",
            $ipAddress
        );
        $duplicateCheckStmt->close();
        handleError("A fine already exists for this Incident ID. Duplicate fines are not allowed.");
    }
    $duplicateCheckStmt->close();

    // ------------ Inserting the fine into Fines table -----------------------//
    $fineQuery = "INSERT INTO Fines (Fine_Amount, Fine_Points, Incident_ID) VALUES (?, ?, ?)";
    $fineStatement = $con->prepare($fineQuery);
    $fineStatement->bind_param("iii", $fineAmount, $finePoints, $incidentId);

    if ($fineStatement->execute()) {
        $newFineId = $fineStatement->insert_id;
        logAudit($con, $officerId, 'Fines', $newFineId,
            'CREATE',
            'New fine created',
            "Amount: £$fineAmount\nPoints: $finePoints\nIncident ID: $incidentId",
            $ipAddress);
        handleSuccess("Fine successfully associated with the incident!");
    } else {
        logAudit($con, $officerId, 'Fines', 0, 'CREATE_FAILED', 'Database error', "Error creating fine: " . $fineStatement->error,
            $ipAddress);
        handleError("Error: Unable to associate the fine. Please try again.");
    }
    $fineStatement->close();
}

// --------------------------------------- processig delete fine ---------------------------------------//
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['delete_fine'])) {
    $officerId = $_SESSION['officer_id'] ?? 0;
    $ipAddress = $_SERVER['REMOTE_ADDR'];
    $fineId = $_POST['fine_id'];

    // ---------------------------------- Getting the fine details before deletio ----------------------------------//
    $getFineQuery = "SELECT * FROM Fines WHERE Fine_ID = ?";
    $getFineStmt = $con->prepare($getFineQuery);
    $getFineStmt->bind_param("i", $fineId);
    $getFineStmt->execute();
    $fineDetails = $getFineStmt->get_result()->fetch_assoc();
    $getFineStmt->close();

    if (!$fineDetails) {
        logAudit($con, $officerId, 'Fines', $fineId, 'DELETE_FAILED', 'Attempted to delete non-existent fine', "Fine ID: $fineId not found", $ipAddress);
        handleError("Fine not found.");
    }

    // ------------------------------------------ Deleting the fine ------------------------------------------//
    $deleteFineQuery = "DELETE FROM Fines WHERE Fine_ID = ?";
    $deleteFineStmt = $con->prepare($deleteFineQuery);
    $deleteFineStmt->bind_param("i", $fineId);

    if ($deleteFineStmt->execute()) {
        logAudit($con, $officerId, 'Fines',
            $fineId,
            'DELETE',
            "Fine details before deletion:\nAmount: £{$fineDetails['Fine_Amount']}\nPoints: {$fineDetails['Fine_Points']}\nIncident ID: {$fineDetails['Incident_ID']}",
            "Fine successfully deleted",
            $ipAddress);
        handleSuccess("Fine deleted successfully.");
    } else {
        logAudit($con, $officerId, 'Fines', $fineId,
            'DELETE_FAILED',
            'Database error',
            "Error deleting fine: " . $deleteFineStmt->error,
            $ipAddress);
        handleError("Error deleting fine.");
    }
    $deleteFineStmt->close();
}
?>


<script src="JS/scripts.js"></script>
</body>
</html>

