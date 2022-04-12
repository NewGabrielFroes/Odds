<?php
include("config.php");
include("Betano.class.php");

$pdo = connect();
$field_type = "Betano";
$url = "https://br.betano.com/adserve?type=OddsComparisonFeed&lang=pt&sport=FOOT";

$platform = new Betano($pdo, $field_type);

$json_decoded = $platform->convert_json_to_object($url);

$platform->run_through_json($json_decoded);