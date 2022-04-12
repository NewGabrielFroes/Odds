<?php

include("config.php");
include("Betano.class.php");

$pdo = connect();
$field_type = "Betano";
$url = "https://br.betano.com/adserve?type=OddsComparisonFeed&lang=pt&sport=FOOT";

if($field_type == "Betano") {
	$platform_type = new Betano($pdo, $field_type);
}
/*else if($field_type == "Placard") {
	$platform_type = new Placard($pdo, $field_type);
}*/

$json_decoded = $platform_type->convert_json_to_object($url);
$platform_type->run_through_json($json_decoded);