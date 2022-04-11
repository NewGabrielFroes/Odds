<?php

include('config.php');

main();

function main() {
	$pdo = connect();
	$url = "https://br.betano.com/adserve?type=OddsComparisonFeed&lang=pt&sport=FOOT";
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
		$fixtures_id = have_match($pdo, $id_home_team_map, $id_away_team_map, $match_date);
		$identifiers = array();
		$odds = array();

		if (!$id_home_team_map or !$id_away_team_map or !$fixtures_id) {
			continue;
		}
		else {
			foreach ($match->market as $market) {	
				$type = $market->type;
				$count = 0;
				foreach ($market->selections as $selection) {
					$selection_name = $selection->name;
					$identifiers[] = $type . $selection_name;
					$odds[] = $selection->price;
					$count++;
				}

			}
			populate($pdo, $field_type, $identifiers, $fixtures_id, $odds);
		}
	}

	curl_close($curl);
}

function get_id_team($pdo, $field_type, $identifier) {
	$stmt = $pdo->prepare("SELECT teams_id FROM teams_map 
						   WHERE field_type = :field_type 
						   AND identifier = :identifier");
	$stmt->bindParam(":field_type", $field_type);
	$stmt->bindParam(":identifier", $identifier);
	$stmt->execute();
	$id = $stmt->fetch(PDO::FETCH_ASSOC);
	$id = !$id ? $id : $id["teams_id"];
	return $id;
}

function populate($pdo, $field_type, $identifiers, $fixtures_id, $odds) {
	$date = gmdate('Y-m-d H:i:s');
	for ($i = 0; $i < count($identifiers); $i++) { 
		
		$fixture_markets_MarketsId = get_markets_maps_MarketsId($pdo, $identifiers[$i], $field_type);
		$is_market_in_table = is_market_in_table($pdo, $fixtures_id, $fixture_markets_MarketsId);
		$id = $is_market_in_table;
		
		
		if (!$is_market_in_table) {
			populate_fixtures_markets($pdo, $fixtures_id, $fixture_markets_MarketsId);
			populate_fixtures_markets_odds($pdo, $odds[$i], $date, $pdo->lastInsertId());
		}
		else {
			update_fixtures_markets_odds($pdo, $odds[$i], $date, $id);
		}
	}
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
	$id = !$id ? $id : $id["id"];
	return $id;
}

function get_markets_maps_MarketsId($pdo, $identifier, $field_type) {
	$stmt = $pdo->prepare("SELECT markets_id FROM markets_map 
						   WHERE identifier = :identifier
						   AND field_type = :field_type");
	$stmt->bindParam(":identifier", $identifier);
	$stmt->bindParam(":field_type", $field_type);
	$stmt->execute();
	$id = $stmt->fetch(PDO::FETCH_ASSOC);
	return $id["markets_id"];
}

function populate_fixtures_markets($pdo, $fixtures_id, $markets_id) {
	$stmt = $pdo->prepare("INSERT INTO fixtures_markets(fixtures_id, markets_id)
						   VALUES (:fixtures_id, :markets_id)");
	$stmt->bindParam(":fixtures_id", $fixtures_id);
	$stmt->bindParam(":markets_id", $markets_id);
	$stmt->execute();
	return $stmt;
}

function update_fixtures_markets($pdo, $fixtures_id, $markets_id, $id) {
	$stmt = $pdo->prepare("UPDATE fixtures_markets
						   SET fixtures_id = :fixtures_id, 
						   markets_id = :markets_id
						   WHERE id = :id");
	$stmt->bindParam(":fixtures_id", $fixtures_id);
	$stmt->bindParam(":markets_id", $markets_id);
	$stmt->bindParam(":id", $id);
	$stmt->execute();
	return $stmt;
}


function update_fixtures_markets_odds($pdo, $odd, $date, $fixtures_markets_id) {
	$stmt = $pdo->prepare("UPDATE fixtures_markets_odds
						   SET odd = :odd, date = :date
						   WHERE fixtures_markets_id = :fixtures_markets_id");
	$stmt->bindParam(":odd", $odd);
	$stmt->bindParam(":date", $date);
	$stmt->bindParam(":fixtures_markets_id", $fixtures_markets_id);
	$stmt->execute();
	return $stmt;
}

function get_fixtures_marketsId($pdo, $fixtures_id) {
	$stmt = $pdo->prepare("SELECT id FROM fixtures_markets
						   WHERE fixtures_id = :fixtures_id");
	$stmt->bindParam(":fixtures_id", $fixtures_id);
	$stmt->execute();
	$arrayIds = $stmt->fetchAll(PDO::FETCH_ASSOC);
	$ids = array();
	foreach ($arrayIds as $id) {
		$ids[] = $id["id"];
	}
	return $ids;
}

function is_market_in_table($pdo, $fixtures_id, $markets_id) {
	$stmt = $pdo->prepare("SELECT id FROM fixtures_markets
						   WHERE fixtures_id = :fixtures_id
						   AND markets_id = :markets_id");
	$stmt->bindParam(":fixtures_id", $fixtures_id);
	$stmt->bindParam(":markets_id", $markets_id);
	$stmt->execute();
	$id = $stmt->fetch(PDO::FETCH_ASSOC);
	$id = !$id ? $id : $id["id"];
	return $id;
}

function populate_fixtures_markets_odds($pdo, $odd, $date, $fixtures_markets_id) {
	$stmt = $pdo->prepare("INSERT INTO fixtures_markets_odds(odd, date,fixtures_markets_id)
						   VALUES (:odd,:date,:fixtures_markets_id)");
	$stmt->bindParam(":odd", $odd);
	$stmt->bindParam(":date", $date);
	$stmt->bindParam(":fixtures_markets_id", $fixtures_markets_id);
	$stmt->execute();
	return $stmt;
}