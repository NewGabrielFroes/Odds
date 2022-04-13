<?php
include("config.php");
include("Betano.class.php");

$pdo = connect();

$platform = new Betano($pdo);

$json_decoded = $platform->get_json_decoded();

$platform->run_through_json($json_decoded);