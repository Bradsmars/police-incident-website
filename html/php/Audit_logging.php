<?php
// -Audit Logging Function for Index.php page
function logAudit($con, $officerId, $tableName, $recordId, $actionType,$beforeChanges, $changes, $ipAddress) {
    $query = "INSERT INTO Audit_Logging (Officer_ID, Table_Name, Record_ID, Action_Type, Changes, Before_Changes, Timestamp, IP_Address) 
              VALUES (?, ?, ?, ?, ?, ?, NOW(), ?)";
    $logStatement = $con->prepare($query);
    $logStatement->bind_param("isissss", $officerId, $tableName, $recordId, $actionType, $changes, $beforeChanges,  $ipAddress);
    $logStatement->execute();
    $logStatement->close();
}









?>
