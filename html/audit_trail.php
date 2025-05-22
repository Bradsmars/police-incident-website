<?php
include("php/auth.php");
include("php/config.php");
include("php/Audit_logging.php");

// -------------------------- Message handling functions ------------------------------------------------//
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

// ------------------------ Checking to see if the user is logged in and has the 'Administrator' role -----------------------//
if (!isset($_SESSION['valid']) || !isset($_SESSION['role']) || $_SESSION['role'] !== 'Administrator') {
    handleError("Access denied. Administrator privileges required.");
}

include("php/header.php");
include("php/sidebar.php");
?>

<!DOCTYPE html>
<html>
<head>
    <title>Audit Trail</title>
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
        <h5><b><i class="fa fa-history"></i> System Audit Trail</b></h5>
    </header>

    <!-------------------------  Filtering Form ------------------------------ -->
    <div class="w3-row-padding">
        <div class="w3-third"></div>
        <div class="w3-third">
            <form class="w3-container w3-card-4 w3-white w3-padding" method="GET">
                <label>Filter by Action Type:</label>
                <select name="action_type" class="w3-select w3-border w3-round">
                    <option value="">All Actions</option>
                    <option value="CREATE">Create</option>
                    <option value="READ">Read</option>
                    <option value="UPDATE">Update</option>
                    <option value="DELETE">Delete</option>
                </select>
                <button class="w3-button w3-blue w3-margin-top w3-round" type="submit">Apply Filter</button>
            </form>
        </div>
        <div class="w3-third"></div>
    </div>

    
    <div class="w3-container w3-padding">
        <div class="w3-responsive">
            <?php
            //------------------- Helper function to handle null values -------------------//
            function safeEscape($value) {
                return htmlspecialchars($value ?? '', ENT_QUOTES, 'UTF-8');
            }

            //--------------------------- Building my   query ------------------------------//
            $query = "SELECT Audit_Logging.*,Officer.Officer_Name
                     FROM Audit_Logging
                     LEFT JOIN Officer ON Audit_Logging.Officer_ID = Officer.Officer_ID";

            //--------------------------  Trying to add the  filter if set ---------------------------//
            if (!empty($_GET['action_type'])) {
                $query .= " WHERE Audit_Logging.Action_Type = ?";
            }
            
            $query .= " ORDER BY Audit_Logging.Timestamp DESC";

            $auditLogStatement = $con->prepare($query);
            if (!$auditLogStatement) {
                handleError("Database error: Unable to prepare statement.");
            }
            
            if (!empty($_GET['action_type'])) {
                if (!$auditLogStatement->bind_param("s", $_GET['action_type'])) {
                    handleError("Database error: Unable to bind parameters.");
                }
            }
            
            if (!$auditLogStatement->execute()) {
                handleError("Database error: Unable to execute query.");
            }

            $result = $auditLogStatement->get_result();

            if ($result && $result->num_rows > 0) {
                echo '<table class="w3-table w3-striped w3-bordered w3-white">
                        <tr class="w3-blue">
                            <th>Time</th>
                            <th>Officer</th>
                            <th>Action</th>
                            <th>Table</th>
                            <th>Record ID</th>
                            <th>Details</th>
                            <th>Changes</th>
                            <th>IP</th>
                        </tr>';

                while ($row = $result->fetch_assoc()) {
                
                    $actionClass = '';
                    switch ($row['Action_Type']) {
                        case 'CREATE': $actionClass = 'w3-text-green'; break;
                        case 'UPDATE': $actionClass = 'w3-text-blue'; break;
                        case 'DELETE': $actionClass = 'w3-text-red'; break;
                        case 'READ': $actionClass = 'w3-text-grey'; break;
                    }

                    echo '<tr>
                            <td>' . date('Y-m-d H:i', strtotime($row['Timestamp'])) . '</td>
                            <td>' . safeEscape($row['Officer_Name']) . '</td>
                            <td class="' . $actionClass . '">' . safeEscape($row['Action_Type']) . '</td>
                            <td>' . safeEscape($row['Table_Name']) . '</td>
                            <td>' . safeEscape($row['Record_ID']) . '</td>
                            <td class="audit-cell">' . nl2br(safeEscape($row['Before_Changes'])) . '</td>
                            <td class="audit-cell">' . nl2br(safeEscape($row['Changes'])) . '</td>
                            <td>' . safeEscape($row['IP_Address']) . '</td>
                        </tr>';
                }
                echo '</table>';
            } else {
                YellowMsg("No audit trail records match the  criteria.");
            }
            $auditLogStatement->close();
            ?>
        </div>
    </div>
</div>

<script src="Js/scripts.js"></script>

</body>
</html>
