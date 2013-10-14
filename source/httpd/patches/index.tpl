<html>
<head>
<title>Cenbia WebStack!</title>
<body>
<?php
if ( !is_null($_GET['phpinfo']) ) {
    phpinfo();
} else {?>
Default site: @ROOT_DIR/site/default<br>
<a href="?phpinfo">PHP Info</a><br>
<a href="/pma">phpMyAdmin</a><br>
<?php } ?>
</body>
</html>
