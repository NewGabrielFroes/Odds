<?php

include('config.php');

main();

function main() {
	$pdo = connect();
	$url = "http://localhost/odds/dados.json";
	$field_type = "Betano";
	$curl = curl_init();

	curl_setopt_array($curl, [
		CURLOPT_HEADER         => false,
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_URL            => $url
	]);

	$response = curl_exec($curl);

	if ($err = curl_error($curl)) {
		echo $err;
	}
	else {
		$decoded = json_decode($response);
	}

	foreach ($decoded as $match) {
		$identifier_home_team = $match->teams[0]->id;
		$identifier_away_team = $match->teams[1]->id;
		$match_date = new DateTime($match->date);
		$match_date = $match_date->format('Y-m-d H:i:s');

		$id_home_team_map = get_id_team($pdo, $field_type, $identifier_home_team);
		$id_away_team_map = get_id_team($pdo, $field_type, $identifier_away_team);
		$identifiers = array();

		if (!$id_home_team_map or !$id_away_team_map) {
			continue;
		}
		else {
			$id_home_team_map = $id_home_team_map["id"];
			$id_away_team_map = $id_away_team_map["id"];
		}
		
	    if (!have_match($pdo, $id_home_team_map, $id_away_team_map, $match_date)) {
			continue;
		}
		else {
			foreach ($match->market as $market) {	
				$type = $market->type;
				$count = 0;
				foreach ($market->selections as $selection) {
					$selection_name = $selection->name;
					switch ($type) {
						case "MRES":
							$identifiers[] = $type . $selection_name;
							break;
						case "HCTG":
							if ($count == 0) {
								$identifiers[] = $type . str_replace("Mais de ", "OVER", $selection_name);
							}
							else {
								$identifiers[] = $type . str_replace("Menos de ", "UNDER", $selection_name);
							}
							break;
						case "BTSC":
							if ($count == 0) {
								$identifiers[] = $type . "YES";
							}
							else {
								$identifiers[] = $type . "NO";
							}
							break;
					}
					$count++;
				}

			}
			foreach ($identifiers as $identifier) {
				print_r("<pre>");
				print_r($identifier." ");
				print_r(get_markets_id($pdo, $identifier)["id"]);
				print_r("</pre>");
			}
		}
	}

	curl_close($curl);
}



function get_id_team($pdo, $field_type, $identifier) {
	$stmt = $pdo->prepare("SELECT id FROM teams_map 
						   WHERE field_type = :field_type 
						   AND identifier = :identifier");
	$stmt->bindParam(":field_type", $field_type);
	$stmt->bindParam(":identifier", $identifier);
	$stmt->execute();
	$id = $stmt->fetch(PDO::FETCH_ASSOC);
	return $id;
}

function have_match($pdo, $id_home_team, $id_away_team, $match_date) {
	$stmt = $pdo->prepare("SELECT id FROM fixtures 
						   WHERE home_team = :id_home_team
						   AND away_team = :id_away_team
						   AND date = :match_date");
	$stmt->bindParam(":id_home_team", $id_home_team);
	$stmt->bindParam(":id_away_team", $id_away_team);
	$stmt->bindParam(":match_date", $match_date);
	$stmt->execute();
	$id = $stmt->fetch(PDO::FETCH_ASSOC);
	return $id;
}

function get_markets_id($pdo, $identifier) {
	$stmt = $pdo->prepare("SELECT id FROM markets_map 
						   WHERE identifier = :identifier");
	$stmt->bindParam(":identifier", $identifier);
	$stmt->execute();
	$id = $stmt->fetch(PDO::FETCH_ASSOC);
	return $id;
}