<?php
abstract class Platform {
	private $pdo;
	private $field_type;
	private $url;
	private $json_decoded;


	public function __construct($pdo) {
		$this->set_pdo($pdo);
	}


	protected function get_pdo() {
		return $this->pdo;
	}

	private function set_pdo($pdo) {
		$this->pdo = $pdo;
	}


	protected function get_field_type() {
		return $this->field_type;
	}

	protected function set_field_type($field_type) {
		$this->field_type = $field_type;
	}

	protected function get_url() {
		return $this->url;
	}

	protected function set_url($url) {
		$this->url = $url;
	}

	public function get_json_decoded() {
		return $this->json_decoded;
	}

	protected function set_json_decoded($json_decoded) {
		$this->json_decoded = $json_decoded;
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
			throw new Exception('Invalid URL');
		}
		else {
			return $response;
		}
	}


	protected function convert_json_to_object() {
		return json_decode($this->connect_to_api($this->get_url()));
	}


	protected function get_team_id_by_field_type__identifier($field_type, $identifier) {
		$stmt = $this->pdo->prepare("SELECT teams_id FROM teams_map 
							   WHERE field_type = :field_type 
							   AND identifier = :identifier");

		$stmt->bindParam(":field_type", $field_type);
		$stmt->bindParam(":identifier", $identifier);

		$stmt->execute();

		$query_result = $stmt->fetch(PDO::FETCH_ASSOC);

		$query_result = !$query_result ? $query_result : $query_result["teams_id"];
		
		return $query_result;
	}

	protected function get_fixture_id_by_home_team__away_team__datetime($id_home_team, $id_away_team, $match_date) {
		$stmt = $this->pdo->prepare("SELECT id FROM fixtures 
							   WHERE home_team = :id_home_team
							   AND away_team = :id_away_team
							   AND date = :match_date");

		$stmt->bindParam(":id_home_team", $id_home_team);
		$stmt->bindParam(":id_away_team", $id_away_team);
		$stmt->bindParam(":match_date", $match_date);

		$stmt->execute();

		$query_result = $stmt->fetch(PDO::FETCH_ASSOC);

		$query_result = !$query_result ? $query_result: $query_result["id"];

		return $query_result;
	}

	protected function get_markets_id_by_identifier__field_type($identifier, $field_type) {
		$stmt = $this->pdo->prepare("SELECT markets_id FROM markets_map 
							   WHERE identifier = :identifier
							   AND field_type = :field_type");

		$stmt->bindParam(":identifier", $identifier);
		$stmt->bindParam(":field_type", $field_type);

		$stmt->execute();

		$query_result = $stmt->fetch(PDO::FETCH_ASSOC);

		$query_result = !$query_result ? $query_result : $query_result["markets_id"];
		
		return $query_result;
	}

	protected function get_id_in_fixtures_markets($fixtures_id, $markets_id) {
		$stmt = $this->pdo->prepare("SELECT id FROM fixtures_markets
							   WHERE fixtures_id = :fixtures_id
							   AND markets_id = :markets_id");

		$stmt->bindParam(":fixtures_id", $fixtures_id);
		$stmt->bindParam(":markets_id", $markets_id);

		$stmt->execute();

		$query_result = $stmt->fetch(PDO::FETCH_ASSOC);

		$query_result = !$query_result ? $query_result : $query_result["id"];

		return $query_result;
	}


	protected function populate_fixtures_markets__fixtures_markets_odds($field_type, $identifier, $odd, $fixtures_id) {
		$market_id = $this->get_markets_id_by_identifier__field_type($identifier, $field_type);
		if(!$market_id) return;
		
		$date = gmdate('Y-m-d H:i:s');	

		$fixtures_markets_id = $this->get_id_in_fixtures_markets($fixtures_id, $market_id);

		if(!$fixtures_markets_id) {
			$this->populate_fixtures_markets($fixtures_id, $market_id);
			$fixtures_markets_id = $this->pdo->lastInsertId();
		}
		
		$this->populate_fixtures_markets_odds($odd, $date, $fixtures_markets_id);
	}

	protected function populate_fixtures_markets($fixtures_id, $markets_id) {
		$stmt = $this->pdo->prepare("INSERT INTO fixtures_markets(fixtures_id, markets_id)
							   VALUES (:fixtures_id, :markets_id)");

		$stmt->bindParam(":fixtures_id", $fixtures_id);
		$stmt->bindParam(":markets_id", $markets_id);

		$stmt->execute();

		return $stmt;
	}

	protected function populate_fixtures_markets_odds($odd, $date, $fixtures_markets_id) {
		$stmt = $this->pdo->prepare("INSERT INTO fixtures_markets_odds(odd, date,fixtures_markets_id)
							   VALUES (:odd,:date,:fixtures_markets_id)");

		$stmt->bindParam(":odd", $odd);
		$stmt->bindParam(":date", $date);
		$stmt->bindParam(":fixtures_markets_id", $fixtures_markets_id);

		$stmt->execute();

		return $stmt;
	}
}