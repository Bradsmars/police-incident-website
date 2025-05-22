<?php 
session_start();
ob_start(); 
include("php/config.php");
include("php/audit_logging.php"); 

if (isset($_POST['submit'])) {
    $username = mysqli_real_escape_string($con, $_POST['username']);
    $password = mysqli_real_escape_string($con, $_POST['password']);

    // ------------------------ Query the OfficerLogin table using prepared statements -----------------------//
    $query = "SELECT Officer_ID, Username, Officer_role FROM OfficerLogin WHERE Username = ? AND Password = ?";
    $loginStatement = $con->prepare($query);
    $loginStatement->bind_param("ss", $username, $password);
    $loginStatement->execute();
    $loginResult = $loginStatement->get_result();
    $row = $loginResult->fetch_assoc();

    if ($row) {
        // ---------------------- Setting session variables ---------------------------------------- //
        $_SESSION['valid'] = $row['Username'];
        $_SESSION['officer_id'] = $row['Officer_ID'];
        $_SESSION['role'] = $row['Officer_role'];

        // --------------------------- Log successful login ---------------------------------------- //
        logAudit($con, $row['Officer_ID'],'OfficerLogin',null,'Login',null,'User logged in successfully',$_SERVER['REMOTE_ADDR']    
        );

        // ---------------------------- Redirecting the to home page --------------------------------------- //
        header("Location: home.php");
        exit(); // Always exit after header redirects
    } else {
        // ------------------------------- Logging failed login attempt --------------------------------------//
        logAudit($con, null,'OfficerLogin',null,'Login',null,'Failed login attempt with username: ' . $username, $_SERVER['REMOTE_ADDR']    
        );

        $error_message = "Wrong Username or Password";
    }

        $loginStatement->close();
    }
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style/login.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
    <title>Login</title>
</head>
<body>
    <div class="container">
        <div class="box form-box">
            <header style="text-align: center;">
                <span style="display: inline-block; vertical-align: middle;">Police Database</span>
            <form action="" method="post">
                <div class="field">
                    <img src="pictures/police.png" alt="Police Logo" style="display: block; margin: 0 auto 20px auto; width: 100px; height: auto;">
                </div>
                <div class="field input">
                    <label for="username">Username</label>
                    <input type="text" name="username" id="username" autocomplete="off" required>
                </div>

                <div class="field input">
                    <label for="password">Password</label>
                    <input type="password" name="password" id="password" autocomplete="off" required>
                </div>

                <div class="field">
                    <input type="submit" class="btn" name="submit" value="Login" required>
                </div>
            </form>
            
            <?php if (isset($error_message)): ?>
            <div class='message'>
                <p><?php echo $error_message; ?></p>
            </div>
            <a href='index.php'><button class='btn'>Go Back</button></a>
            <?php endif; ?>
        </div>
    </div>
</body>
</html>

<?php 
// handling buffering 
if (ob_get_length()) {
    ob_end_flush(); // End output buffering if it is active.
}
?>
