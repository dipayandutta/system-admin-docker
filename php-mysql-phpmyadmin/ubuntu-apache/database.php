<?php
    $servername = "10.5.0.5";
    $username = "sbadmin";
    $password = "sbpassword";

    // Create connection
    $con = mysqli_connect($servername, $username, $password);

    // Check connection
    if (!$con) {
        die("Connection failed:--> " . mysqli_connect_error());
    }
    echo "Connected successfully";

    #$sql="show databases;"
    #echo "--";
?>

