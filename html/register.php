<?php
include("php/auth.php");
include("php/config.php");

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
    <title>Create Officer</title>
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
<!-- Header -->
<header class="w3-container">
    <h5><b><i class="fa fa-user-plus"></i> Add New Officer</b></h5>
</header>

<!-- Officer Registration Form -->
<div class="w3-row-padding">
    <div class="w3-third"></div>
    <div class="w3-third">
        <div class="w3-container w3-card-4 w3-light-grey w3-text-black w3-margin">
            <h2 class="w3-center">Register New Officer</h2>
            <form action="register.php" method="POST">


                <div class="w3-section">
                    <label for="officer_name">Officer Name</label>
                    <input class="w3-input w3-border" type="text" id="officer_name" name="officer_name" required>
                </div>

                <div class="w3-section">
                    <label for="badge_number">Badge Number</label>
                    <input class="w3-input w3-border" type="text" id="badge_number" name="badge_number" required>
                </div>

                <div class="w3-section">
                    <label for="username">Username</label>
                    <input class="w3-input w3-border" type="text" id="username" name="username" required>
                </div>

                <div class="w3-section">
                    <label for="password">Password</label>
                    <input class="w3-input w3-border" type="password" id="password" name="password" required>
                </div>

                <div class="w3-section">
                    <label for="role">Role</label>
                    <select class="w3-select w3-border" id="role" name="role" required>
                        <option value="" disabled selected>Choose role</option>
                        <option value="Administrator">Administrator</option>
                        <option value="User">User</option>
                    </select>
                </div>

                <div class="w3-section">
                    <label for="officer_rank">Rank</label>
                    <input class="w3-input w3-border" type="text" id="officer_rank" name="officer_rank">
                </div>

                <div class="w3-section">
                    <label for="department">Department</label>
                    <input class="w3-input w3-border" type="text" id="department" name="department">
                </div>

                <div class="w3-section">
                    <label for="email">Email</label>
                    <input class="w3-input w3-border" type="email" id="email" name="email">
                </div>

                <div class="w3-section">
                    <label for="phone_number">Phone Number</label>
                    <input class="w3-input w3-border" type="text" id="phone_number" name="phone_number">
                </div>



                <button type="submit" class="w3-button w3-block w3-green w3-section w3-padding">Register</button>
            </form>
        </div>
    </div>
    <div class="w3-third"></div>
</div>
</div>
</div>



<?php
include("php/Audit_logging.php");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    $ipAddress = $_SERVER['REMOTE_ADDR'];
    $adminId = $_SESSION['officer_id'] ?? 0; // Get the admin's officer ID

    // ------------------ Collecting form data -------------------------//
    $officerName = $_POST['officer_name'];
    $badgeNumber = $_POST['badge_number'];
    $rank = $_POST['officer_rank'];
    $department = $_POST['department'];
    $email = $_POST['email'];
    $phoneNumber = $_POST['phone_number'];
    $username = $_POST['username'];
    $password = $_POST['password'];
    $role = $_POST['role'];
    
    // ------------------ Error handling functions ----------------------//
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

    // -------------------------------- Validating inputs --------------------------------//
    if (empty($officerName) || empty($badgeNumber) || empty($username) || empty($password) || empty($role)) {
        logAudit($con,$adminId,'Officer',0,'CREATE_FAILED',
            'Attempted to create officer with missing required fields',
            'Missing required fields in officer registration form',
            $ipAddress);
        handleError("All fields are needed to be filled in, except rank, department, email, and phone number");
    }

    // ------------------------ Checking for duplicate badge number ------------------------//
    $checkBadgeQuery = "SELECT Officer.Officer_ID FROM Officer WHERE Officer.Officer_BadgeNumber = ?";
    $badgeCheckStatement = $con->prepare($checkBadgeQuery);
    $badgeCheckStatement->bind_param("s", $badgeNumber);
    $badgeCheckStatement->execute();
    $badgeCheckStatement->store_result();
    
    if ($badgeCheckStatement->num_rows > 0) {
        $badgeCheckStatement->close();
        logAudit($con,$adminId,'Officer',0,'CREATE_FAILED',
            'Attempted to create officer with duplicate badge number',
            "Duplicate badge number: $badgeNumber",
            $ipAddress
        );
        YellowMsg("Duplicate badge number !, use a different badge number.");
    }
    $badgeCheckStatement->close();


// -------------------------- Checking for duplicate badge number --------------------------//
    $checkBadgeQuery = "SELECT Officer.Officer_ID FROM Officer WHERE Officer.Officer_BadgeNumber = ?";
    $badgeCheckStatement = $con->prepare($checkBadgeQuery);
    $badgeCheckStatement->bind_param("s", $badgeNumber);
    $badgeCheckStatement->execute();
    $badgeCheckStatement->store_result();
    
    if ($badgeCheckStatement->num_rows > 0) {
        $badgeCheckStatement->close();
        logAudit($con,$adminId,'Officer',0,'CREATE_FAILED',
            'Attempted to create officer with duplicate badge number',
            "Duplicate badge number: $badgeNumber",
            $ipAddress
        );
        YellowMsg("Duplicate badge number !, use a different badge number.");
    }
    $badgeCheckStatement->close();

// ---------------- Checking for duplicate email if email if one is provided by the user ----------------//
    if (!empty($email)) {
        $checkEmailQuery = "SELECT Officer.Officer_ID FROM Officer WHERE Officer.Email = ?";
        $emailCheckStatement = $con->prepare($checkEmailQuery);
        $emailCheckStatement->bind_param("s", $email);
        $emailCheckStatement->execute();
        $emailCheckStatement->store_result();
        
        if ($emailCheckStatement->num_rows > 0) {
            $emailCheckStatement->close();
            logAudit($con,$adminId,'Officer',0,'CREATE_FAILED','Attempted to create officer with duplicate email',
                "Duplicate email address: $email",
                $ipAddress);
            YellowMsg("This email is already registered in the system. Please use a different email address.");
        }
        $emailCheckStatement->close();}

    //  --------------------- Inserting officer details ----------------------//
    $insertOfficerQuery = "INSERT INTO Officer 
                          (Officer.Officer_Name, 
                           Officer.Officer_BadgeNumber, 
                           Officer.Officer_Rank, 
                           Officer.Department, 
                           Officer.Email, 
                           Officer.Phone_Number) 
                          VALUES (?, ?, ?, ?, ?, ?)";

    $insertOfficerStatement = $con->prepare($insertOfficerQuery);
    $insertOfficerStatement->bind_param("ssssss", $officerName, $badgeNumber, $rank, $department, $email, $phoneNumber);

    if (!$insertOfficerStatement->execute()) {
        logAudit($con,$adminId,'Officer',0,'CREATE_FAILED','Failed to insert officer details',"Error: " . $insertOfficerStatement->error,
            $ipAddress);

        $insertOfficerStatement->close();
        handleError("Error !! registering officer, please try again.");
    }
    $newOfficerId = $insertOfficerStatement->insert_id;
    $insertOfficerStatement->close();

//-------------------- Inserting login details ---------------------------//
    $insertLoginQuery = "INSERT INTO OfficerLogin 
                        (OfficerLogin.Officer_ID, 
                         OfficerLogin.Username, 
                         OfficerLogin.Password, 
                         OfficerLogin.Officer_role) 
                        VALUES (?, ?, ?, ?)";
    $insertLoginStatement = $con->prepare($insertLoginQuery);
    $insertLoginStatement->bind_param("isss", $newOfficerId, $username, $password, $role);
    
    if (!$insertLoginStatement->execute()) {
        logAudit(
            $con,
            $adminId,
            'Officer',
            $newOfficerId,
            'CREATE_FAILED',
            'Officer created but login details failed',
            "Error creating login: " . $insertLoginStatement->error,
            $ipAddress
        );
        $insertLoginStatement->close();
        handleError("Error !! creating officer login try again.");
    }
    $insertLoginStatement->close();

// ----------------- Logging successful officer make --------------------//
    $changes = "Officer Details:\n" .
              "Name: $officerName\n" .
              "Badge: $badgeNumber\n" .
              "Rank: $rank\n" .
              "Department: $department\n" .
              "Email: $email\n" .
              "Phone: $phoneNumber\n" .
              "Role: $role";

    logAudit($con,$adminId,'Officer',$newOfficerId,'CREATE','New officer registration',$changes,$ipAddress);

    handleSuccess("Officer registered successfully!");
}
?>

<!-- JS file -->
<script src="JS/scripts.js"></script>
</body>
</html>