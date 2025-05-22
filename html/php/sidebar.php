<!--------------------------------------------- Sidebar/menu ----------------------------------------------->
<nav class="w3-sidebar w3-collapse w3-white w3-animate-left" id="mySidebar">
    <div class="w3-container w3-row">
        <div class="w3-col s4">
            <img src="pictures/avatar.png" class="w3-circle" alt="Avatar">
        </div>
        <div class="w3-col s8 w3-bar">
            <span>Welcome, <strong><?php echo htmlspecialchars($officer_name); ?></strong></span><br>
            <a href="profile.php" class="w3-bar-item w3-button"><i class="fa fa-user"></i> Profile</a>
            <a href="settings.php" class="w3-bar-item w3-button"><i class="fa fa-cog"></i> Settings</a>
        </div>
    </div>
    <hr>
    <div class="w3-container">
        <h5>Menu</h5>
    </div>
    <div class="w3-bar-block">
        <a href="home.php" class="w3-bar-item w3-button"><i class="fa fa-home"></i> Dashboard</a>
        
        <!----------------------------------------Vehicles Submenu -------------------------------------------->
        <button class="w3-button w3-block w3-left-align" onclick="toggleMenu('vehiclesMenu')">
            <i class="fa fa-car"></i> Vehicles <i class="fa fa-caret-down"></i>
        </button>
        <div id="vehiclesMenu" class="w3-hide w3-white w3-card">
            <a href="search_vehicle.php" class="w3-bar-item w3-button"><i class="fa fa-search"></i> Search Vehicles</a>
            <a href="add_vehicle.php" class="w3-bar-item w3-button"><i class="fa fa-plus"></i> Add Vehicle</a>
            <a href="update_owner.php" class="w3-bar-item w3-button"><i class="fa fa-edit"></i> Update Vehicle Owner</a>
        </div>
        
        <!------------------------------------- Incidents Submenu ------------------------------------------>
        <button class="w3-button w3-block w3-left-align" onclick="toggleMenu('incidentsMenu')">
            <i class="fa fa-file-text"></i> Incidents <i class="fa fa-caret-down"></i>
        </button>
        <div id="incidentsMenu" class="w3-hide w3-white w3-card">
            <a href="file_incident.php" class="w3-bar-item w3-button"><i class="fa fa-file-text"></i> File Incident</a>
            <a href="search_incident.php" class="w3-bar-item w3-button"><i class="fa fa-search"></i> Search & Edit Incidents</a>
        </div>

        <!----------------------------------------- Admin pages  ------------------------------------------->
        <?php if (isset($_SESSION['role']) && $_SESSION['role'] === 'Administrator'): ?>
        <button class="w3-button w3-block w3-left-align" onclick="toggleMenu('adminMenu')">
            <i class="fa fa-user-shield"></i> Admin Drop Down <i class="fa fa-caret-down"></i>
        </button>
        <div id="adminMenu" class="w3-hide w3-white w3-card">
            <a href="audit_trail.php" class="w3-bar-item w3-button"><i class="fa fa-history"></i> Audit trail</a>
            <a href="register.php" class="w3-bar-item w3-button"><i class="fa fa-user-plus"></i> Register Officer</a>
            <a href="delete_officer.php" class="w3-bar-item w3-button"><i class="fa fa-minus"></i> Remove Officer</a>
            <a href="add_fine.php" class="w3-bar-item w3-button"><i class="fa fa-money"></i> Manage Fines</a>
            <a href="create_offence.php" class="w3-bar-item w3-button"><i class="fa fa-plus-circle"></i> Create Offence</a>
            <a href="delete_offence.php" class="w3-bar-item w3-button"><i class="fa fa-trash"></i> Delete Offence</a>
        </div>
        <?php endif; ?>

        <!----------------------------------------- Log Out -------------------------------------------------->
        <a href="php/logout.php" class="w3-bar-item w3-button"><i class="fa fa-sign-out"></i> Log Out</a>
    </div>
</nav>
<script src="JS/scripts.js"></script>

