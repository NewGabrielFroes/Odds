<?php
# Begin



include('config.php');

include('Platform.class.php');
include('Betano.class.php');
include('Placard.class.php');



$pdo = connect();


$platform = new Placard($pdo);

$json_decoded = $platform->get_json_decoded();
$platform->run_through_json($json_decoded);


$platform = new Betano($pdo);

$json_decoded = $platform->get_json_decoded();
$platform->run_through_json($json_decoded);



# End
