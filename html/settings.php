<?php
include("php/header.php");
include("php/sidebar.php");


if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

// Checking to see  if the user is logged in
if (!isset($_SESSION['valid'])) {
    header("Location: index.php");
    exit();
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Settings</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="style/pages.css"> <!-- Link your external CSS -->
</head>
<body class="w3-light-grey">
    <!-- Overlay effect for small screens -->
    <div class="w3-overlay w3-hide-large" onclick="w3_close()" id="myOverlay"></div>

    <!-- Page content -->
    <div class="w3-main">
        <!-- Header -->
        <header class="w3-container">
            <h5><b><i class="fa fa-cog"></i> Settings</b></h5>
        </header>

        <div class="w3-container">
            <form action="" method="POST">
                <div class="settings-item">
                    <label for="current_password">Current Password</label>
                    <input class="w3-input w3-border" type="password" id="current_password" name="current_password" required>
                </div>
                <div class="settings-item">
                    <label for="new_password">New Password</label>
                    <input 
                        class="w3-input w3-border" 
                        type="password" 
                        id="new_password" 
                        name="new_password" 
                        pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" 
                        title="Must contain at least one number, one uppercase and lowercase letter, and at least 8 or more characters" 
                        required>
                </div>
                <div class="w3-item">
                    <label for="confirm_password">Confirm New Password</label>
                    <input class="w3-input w3-border" type="password" id="confirm_password" name="confirm_password" required>
                </div>
                <div class="settings-item">
                    <button type="submit" class="w3-button w3-blue">Change Password</button>
                </div>
            </form>
        </div>
    </div>
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

function YellowMsg($message) {
    echo "<div class='w3-container yellow-msg'><p>$message</p></div>";
    exit();
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $currentPasswordInput = mysqli_real_escape_string($con, $_POST['current_password']);
    $newPasswordInput = mysqli_real_escape_string($con, $_POST['new_password']);
    $confirmPasswordInput = mysqli_real_escape_string($con, $_POST['confirm_password']);

    // --------------------- Validating the current password --------------------- //
    $fetchCurrentPasswordQuery = "SELECT Password FROM OfficerLogin WHERE Officer_ID = ?";
    $fetchCurrentPasswordStatement = $con->prepare($fetchCurrentPasswordQuery);
    $fetchCurrentPasswordStatement->bind_param("i", $officer_id);
    $fetchCurrentPasswordStatement->execute();
    $fetchCurrentPasswordStatement->bind_result($storedPassword);
    $fetchCurrentPasswordStatement->fetch();
    $fetchCurrentPasswordStatement->close();

    // ------------------------ Checking  if the current password matches the database ------------------------ //
    if ($storedPassword === $currentPasswordInput) {
        if ($newPasswordInput === $confirmPasswordInput) {
            // ----------------------- Updating my password ----------------------- //
            $updatePasswordQuery = "UPDATE OfficerLogin SET Password = ? WHERE Officer_ID = ?";
            $updatePasswordStatement = $con->prepare($updatePasswordQuery);
            $updatePasswordStatement->bind_param("si", $newPasswordInput, $officer_id);
            if ($updatePasswordStatement->execute()) {
                handleSuccess("Password updated successfully.");
            } else {
                handleError("Failed to update password. Please try again.");
            }
            $updatePasswordStatement->close();
        } else {
            handleError("New passwords do not match.");
        }
    } else {
        handleError("Incorrect current password.");
    }
}
?>
