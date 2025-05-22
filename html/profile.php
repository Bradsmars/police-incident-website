<?php
include("php/header.php");
include("php/sidebar.php");
?>

<?php 
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

?>
<!DOCTYPE html>
<html>
<head>
    <title>Officer Profile</title>
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
<!-- header -->
<header class="w3-container">
        <h5><b><i class="fa fa"></i> Officer</b></h5>
    </header>

    <!-- Profile Card -->
     <!-- Reference: https://www.w3schools.com/howto/howto_css_profile_card.asp -->
     <!-- The form structures and styling for the 'profile' page was inspired by a W3Schools tutorial on 'How TO - Profile Card'.
          Reference: W3Schools CSS Forms Example. -->
    <h2 style="text-align:center">Officer Profile</h2>
    <div class="card">
        <img src="pictures/avatar.png" alt="Officer Avatar" style="width:100%">
        
        <?php
        // getting officer details from the database
        $officer_id = isset($_SESSION['officer_id']) ? $_SESSION['officer_id'] : "";
        $officer_details = [];

        if ($officer_id) {
            $query = "SELECT Officer_Name, Officer_BadgeNumber, Officer_Rank, Department, Email, Phone_Number 
                      FROM Officer 
                      WHERE Officer_ID = ?";
            $stmt = $con->prepare($query);
            $stmt->bind_param("i", $officer_id);
            $stmt->execute();
            $result = $stmt->get_result();
            $officer_details = $result->fetch_assoc();
            $stmt->close();
        }
        ?>

        <h1><?php echo htmlspecialchars($officer_details['Officer_Name'] ?? 'N/A'); ?></h1>
        <p class="title"><?php echo htmlspecialchars($officer_details['Officer_Rank'] ?? 'N/A'); ?></p>
        <p><?php echo htmlspecialchars($officer_details['Department'] ?? 'N/A'); ?></p>
        <div style="margin: 24px 0;">
            <p><strong>Badge Number:</strong> <?php echo htmlspecialchars($officer_details['Officer_BadgeNumber'] ?? 'N/A'); ?></p>
            <p><strong>Email:</strong> <?php echo htmlspecialchars($officer_details['Email'] ?? 'N/A'); ?></p>
            <p><strong>Phone:</strong> <?php echo htmlspecialchars($officer_details['Phone_Number'] ?? 'N/A'); ?></p>
        </div>
    </div>
</div>

<!-- JS file -->
<script src="js/scripts.js"></script>

</body>
</html>
