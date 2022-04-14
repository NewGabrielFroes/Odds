<?php
include("config.php");
include("Betano.class.php");
include("Placard.class.php");

$pdo = connect();

$platform = new Placard($pdo);

$json_decoded = $platform->get_json_decoded();

$platform->run_through_json($json_decoded);