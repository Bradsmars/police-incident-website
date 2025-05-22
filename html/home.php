<?php
include("php/header.php");
include("php/sidebar.php");
?>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="style/pages.css">

</head>
<body class="w3-light-grey">
<!-- https://www.w3schools.com/w3css/w3css_web_css.asp -->
 
<div class="w3-main" style="margin-left:300px;">
    <!-- Header -->
    <header class="w3-container">
        <h5><b><i class="fa fa-shield"></i> Police Management Dashboard</b></h5>
    </header>

    <!-- Dashboard Cards -->
    <div class="w3-row-padding">
        <!-- Search Vehicle Card -->
        <div class="w3-quarter card-spacing">
            <a href="search_vehicle.php" style="text-decoration: none;">
                <div class="w3-container w3-blue">
                    <div class="w3-left"><i class="fa fa-car w3-xxxlarge"></i></div>
                    <div class="w3-right">
                        <h3>Search</h3>
                    </div>
                    <div class="w3-clear"></div>
                    <h4>Search Vehicles</h4>
                </div>
            </a>
        </div>

            <!-- Dashboard Cards -->
    <div class="w3-row-padding">
        <!-- Search Vehicle Card -->
        <div class="w3-quarter card-spacing">
            <a href="update_owner.php" style="text-decoration: none;">
                <div class="w3-container w3-blue">
                    <div class="w3-left"><i class="fa fa-plus w3-xxxlarge"></i></div>
                    <div class="w3-right">
                        <h3>Search</h3>
                    </div>
                    <div class="w3-clear"></div>
                    <h4>Update Existing Vehicle Owner</h4>
                </div>
            </a>
        </div>

        <!-- Add Vehicle Card -->
        <div class="w3-quarter card-spacing">
            <a href="add_vehicle.php" style="text-decoration: none;">
                <div class="w3-container w3-blue">
                    <div class="w3-left"><i class="fa fa-plus w3-xxxlarge"></i></div>
                    <div class="w3-right">
                        <h3>Add</h3>
                    </div>
                    <div class="w3-clear"></div>
                    <h4>Add Vehicles & Add New person</h4>
                </div>
            </a>
        </div>

        <!-- File Incident Card -->
        <div class="w3-quarter card-spacing">
            <a href="file_incident.php" style="text-decoration: none;">
                <div class="w3-container w3-purple">
                    <div class="w3-left"><i class="fa fa-file-text w3-xxxlarge"></i></div>
                    <div class="w3-right">
                        <h3>File</h3>
                    </div>
                    <div class="w3-clear"></div>
                    <h4>File Incident</h4>
                </div>
            </a>
        </div>

        <!-- Edit Incident Card -->
        <div class="w3-quarter card-spacing">
            <a href="search_incident.php" style="text-decoration: none;">
                <div class="w3-container w3-purple">
                    <div class="w3-left"><i class="fa fa-pencil w3-xxxlarge"></i></div>
                    <div class="w3-right">
                        <h3>Edit</h3>
                    </div>
                    <div class="w3-clear"></div>
                    <h4>Search & Edit Incident</h4>
                </div>
            </a>
        </div>
        </div>
    </div>
</div>

<!-- JS file -->
<script src="js/scripts.js"></script>

</body>
</html>
