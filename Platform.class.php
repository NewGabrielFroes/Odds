<?php
abstract class Platform {
	private $pdo;
	private $field_type;

	public function __construct($pdo, $field_type) {
		$this->set_pdo($pdo);
		$this->set_field_type($field_type);
	}

	protected function get_field_type() {
		return $this->field_type;
	}

	protected function get_pdo() {
		return $this->pdo;
	}

	private function set_field_type($field_type) {
		$this->field_type = $field_type;
	}

	private function set_pdo($pdo) {
		$this->pdo = $pdo;
	}

	private function connect_to_api($url) {
		$curl = curl_init();

		curl_setopt_array($curl, [
			CURLOPT_HEADER         => false,
			CURLOPT_RETURNTRANSFER => true,
			CURLOPT_URL            => $url
		]);

		$response = curl_exec($curl);

		curl_close($curl);

		if($err = curl_error($curl)) {
			throw new Exception("Invalid URL");
		}
		else {
			return $response;
		}
	}

	public function convert_json_to_object($url){return json_decode($this->connect_to_api($url));}

	protected function get_team_id_by_field_type__identifier($pdo, $field_type, $identifier) {
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

	protected function get_fixture_id_by_home_team__away_team__datetime($pdo, $id_home_team, $id_away_team, $match_date) {
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

	protected function populate($pdo, $field_type, $identifier, $odd, $fixtures_id) {
		$date = gmdate('Y-m-d H:i:s');	
		$market_id = $this->get_markets_id_by_identifier__field_type($pdo, $identifier, $field_type);
		$fixtures_markets_id = $this->is_market_in_table($pdo, $fixtures_id, $market_id);
			
		if(!$fixtures_markets_id) {
			$this->populate_fixtures_markets($pdo, $fixtures_id, $market_id);
			$this->populate_fixtures_markets_odds($pdo, $odd, $date, $pdo->lastInsertId());
		}
		else {
			$this->populate_fixtures_markets_odds($pdo, $odd, $date, $fixtures_markets_id);
		}
	}

	protected function get_markets_id_by_identifier__field_type($pdo, $identifier, $field_type) {
		$stmt = $pdo->prepare("SELECT markets_id FROM markets_map 
							   WHERE identifier = :identifier
							   AND field_type = :field_type");
		$stmt->bindParam(":identifier", $identifier);
		$stmt->bindParam(":field_type", $field_type);
		$stmt->execute();
		$id = $stmt->fetch(PDO::FETCH_ASSOC);
		return $id["markets_id"];
	}

	protected function is_market_in_table($pdo, $fixtures_id, $markets_id) {
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

	protected function populate_fixtures_markets($pdo, $fixtures_id, $markets_id) {
		$stmt = $pdo->prepare("INSERT INTO fixtures_markets(fixtures_id, markets_id)
							   VALUES (:fixtures_id, :markets_id)");
		$stmt->bindParam(":fixtures_id", $fixtures_id);
		$stmt->bindParam(":markets_id", $markets_id);
		$stmt->execute();
		return $stmt;
	}

	protected function populate_fixtures_markets_odds($pdo, $odd, $date, $fixtures_markets_id) {
		$stmt = $pdo->prepare("INSERT INTO fixtures_markets_odds(odd, date,fixtures_markets_id)
							   VALUES (:odd,:date,:fixtures_markets_id)");
		$stmt->bindParam(":odd", $odd);
		$stmt->bindParam(":date", $date);
		$stmt->bindParam(":fixtures_markets_id", $fixtures_markets_id);
		$stmt->execute();
		return $stmt;
	}
}