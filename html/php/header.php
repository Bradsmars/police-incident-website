<?php
include("auth.php");
?>
<!-- Top container -->
<div class="w3-bar w3-top w3-black w3-large">
    <button class="w3-bar-item w3-button w3-hide-large" onclick="w3_open();">
        <i class="fa fa-bars"></i> Menu
    </button>
    <img src="pictures/database.png" alt="Logo" class="w3-bar-item w3-right" style="height:40px;">
    <!-- Time display -->
    <!-- Reference: wk08-02-DIS-COMP4039-css-dom-js-new -->
    <span class="w3-bar-item w3-right" id="time-container" style="height:40px; line-height: 0px;">
        <script src="JS/scripts.js"></script>
        <script>
            displayCurrentTime();
        </script>
    </span>
</div>




