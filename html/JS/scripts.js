// --------------------------------Sidebar Functions -----------------------------------------
//Reference: https://www.w3schools.com/w3css/w3css_sidebar.asp
function w3_open() {
    document.getElementById("mySidebar").style.display = "block";
    document.getElementById("myOverlay").style.display = "block";
}
//Reference: https://www.w3schools.com/w3css/w3css_sidebar.asp
function w3_close() {
    document.getElementById("mySidebar").style.display = "none";
    document.getElementById("myOverlay").style.display = "none";
}

//Reference: https://www.w3schools.com/js/js_validation.asp
function displayCurrentTime() {
    document.write("<p id=\"current-time\">" + Date() + "</p>");
}
//---------------------------------End of Sidebar Functions -----------------------------------------



// ---------------------------------File_Incident.php page -----------------------------------------
//https://stackoverflow.com/questions/11847806/javascript-date-set-just-the-date-ignoring-time
function setMaxIncidentDate() {
    const incidentDateInput = document.getElementById('incident_date');
    if (incidentDateInput) { 
        const today = new Date().toISOString().split('T')[0]; 
        incidentDateInput.setAttribute('max', today);
    }
}
document.addEventListener('DOMContentLoaded', setMaxIncidentDate);




//---------------------------------sidebar.php page -----------------------------------------//
// Function to toggle submenus
function toggleMenu(menuId) {
    var menu = document.getElementById(menuId);
    if (menu.classList.contains('w3-show')) {
        menu.classList.remove('w3-show');
    } else {
        menu.classList.add('w3-show');
    }
}





//----------- -----------------------Add_Vehical.php page ---------------------------------//
// Add new person to existing owner form
function validateForm() {
    let currentOwnerLicence = document.getElementById('current_owner_licence').value.trim();
    let newOwnerLicence = document.getElementById('new_owner_licence').value.trim();

    if (currentOwnerLicence.length < 15 || currentOwnerLicence.length > 16) {
        alert("Current Owner Licence must be between 15 and 16 characters.");
        return false; // Prevent form submission
    }

    if (newOwnerLicence.length < 15 || newOwnerLicence.length > 16) {
        alert("New Owner Licence must be between 15 and 16 characters.");
        return false; // Prevent form submission
    }

    return true; // Allow form submission
}

// for the add new vehical form
function validateAddVehicalForm() {
    let vehiclePlate = document.getElementById('vehicle_plate').value.trim();

    if (vehiclePlate.length !== 6) {
        alert("Registration Plate must be exactly 6 characters.");
        return false; // Prevent form submission
    }

    return true; // Allow form submission

}
// for the add new person form
function validateAddPersonForm() {
    let newOwnerLicence = document.getElementById('owner_licence').value.trim();
    let ownerName = document.getElementById('owner_name').value.trim();

    if (newOwnerLicence.length < 15 || newOwnerLicence.length > 16) {
        alert(" Licence number / People licence must be between 15 and 16 characters.");
        return false; // Prevent form submission
    }

    // Check if name contains numbers
    if (/\d/.test(ownerName)) {
        alert(" Name cannot contain numbers.");
        return false;
    }

}
//---------------------------------End of Add_Vehical.php page ---------------------------------//



//---------------------------------File_Person.php page -----------------------------------------//

function validateFileIncidentForm() {
    let PersonLicence = document.getElementById('person_licence').value.trim();
    let offenceWriteUp = document.getElementById('incident_report').value.trim();

    if (PersonLicence.length < 15 || PersonLicence.length > 16) {
        alert(" Licence number / People licence must be between 15 and 16 characters.");
        return false; // Prevent form submission
    }

    // Validate offence details
    if (offenceWriteUp.length < 20) {
        alert("Offence report must be at least 20 characters.");
        return false;
    }
    

}

//--------------------------------- Delete offcer.php page -----------------------------------------//
function deleteOfficerForm() {
    let officerID = document.getElementById('officer_id').value.trim();

    // Validate that Officer ID is numeric
    if (officerID === '' || isNaN(officerID)) {
        alert("Officer ID must be a numeric value.");
        return false; // Prevent form submission
    }

    return true; // Allow form submission
}

//--------------------------------- search_incident.php page ---------------------------------------//







