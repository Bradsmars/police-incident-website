<!-- Connecting to the database -->
<?php 
 
 $con = mysqli_connect(
"mariadb",
"root",
"rootpwd",
"cw2-database") or die("Couldn't connect");

?>