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
			for ($i = 0; $i < count($identifiers); ++$i) {
				$identifiers[$i] = str_replace("Mais de ", "OVER", $identifiers[$i]);
				$identifiers[$i] = str_replace("Menos de ", "UNDER", $identifiers[$i]);
				$identifiers[$i] = str_replace("Sim", "YES", $identifiers[$i]);
				$identifiers[$i] = str_replace("Não", "NO", $identifiers[$i]);
				$fixture_marketsMarketsId = get_fixture_marketsMarketsId($pdo, $identifiers[$i]);
				$date = gmdate('Y-m-d H:i:s');
				if (!is_market_in_table($pdo, $fixtures_id, $fixture_marketsMarketsId)) {
					populate_fixtures_markets($pdo, $fixtures_id, $fixture_marketsMarketsId);
					$fixtures_marketsIds = get_fixtures_marketsId($pdo, $fixtures_id); //RETIRAR
					populate_fixtures_markets_odds($pdo, $odds[$i], $date, $fixtures_marketsIds[$i]);
				}
				else {
					$fixtures_marketsIds = get_fixtures_marketsId($pdo, $fixtures_id);
					update_fixtures_markets_odds($pdo, $odds[$i], $date, $fixtures_marketsIds[$i]);
				}
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
	$id = !$id ? $id : $id["id"];
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
	$id = !$id ? $id : $id["id"];
	return $id;
}

function get_fixture_marketsMarketsId($pdo, $identifier) {
	$stmt = $pdo->prepare("SELECT id FROM markets_map 
						   WHERE identifier = :identifier");
	$stmt->bindParam(":identifier", $identifier);
	$stmt->execute();
	$id = $stmt->fetch(PDO::FETCH_ASSOC);
	return $id["id"];
}

function populate_fixtures_markets($pdo, $fixtures_id, $markets_id) {
	$stmt = $pdo->prepare("INSERT INTO fixtures_markets(fixtures_id, markets_id)
						   VALUES (:fixtures_id, :markets_id)");
	$stmt->bindParam(":fixtures_id", $fixtures_id);
	$stmt->bindParam(":markets_id", $markets_id);
	$stmt->execute();
	return $stmt;
}

/*function update_fixtures_markets($pdo, $fixtures_id, $markets_id, $id) { FALTA
	$stmt = $pdo->prepare("UPDATE fixtures_markets_odds
						   SET odd = :odd, date = :date
						   WHERE fixtures_markets_id = :fixtures_markets_id");
	$stmt->bindParam(":odd", $odd);
	$stmt->bindParam(":date", $date);
	$stmt->bindParam(":fixtures_markets_id", $fixtures_markets_id);
	$stmt->execute();
	return $stmt;
}*/


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